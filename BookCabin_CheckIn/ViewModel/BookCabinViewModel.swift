//
//  BookCabinViewModel.swift
//  BookCabin_CheckIn
//
//  Created by Ubaidillah Ahmad on 07/12/25.
//

import Foundation
import SwiftUI

final class BookCabinViewModel: ObservableObject {
    
    let checkInService: CheckInServiceProtocol
    
    init(checkInService: CheckInServiceProtocol = CheckInService()) {
        self.checkInService = checkInService
    }
    
    struct State {
        var pnr: String = ""
        var passengerId: String = ""
        var firstName: String = ""
        var lastName: String = ""
        var gender: Gender? = nil
        var document: Document? = nil
        let auth = "VmpFNlQwUk5NREpUUnpwUFJEcFBSQT09OlRVOUNNbE5IVDBRPQ=="
        var accessToken: String = ""
        var sessionId: String = ""
        var displayState: DisplayState = .onlineCheckIn
        var flightDetail: FlightDetail? = nil
        var seqNumber: String = ""
        var barCode: String = ""
        var seatNumber: String = ""
    }
    
    enum Gender {
        case male, female
    }
    
    enum DisplayState {
        case onlineCheckIn, reservationNotFound, passengerDetails, checkIn, barcode
    }
    
    @Published private(set) var state = State()
    
    indirect enum Action {
        case checkInViewOnAppear
        case getToken(action: Action?)
        case onlineCheckIn(pnr: String, lastName: String)
        case getDocument
        case saveDocument(Document)
        case checkIn
        case updateDisplayState(DisplayState)
    }

    func send(_ action: Action) {
        reducer(action)
    }

    private func reducer(_ action: Action) {
        switch action {
            
        case .checkIn:
            checkInService.checkIn(passengerId: state.passengerId, token: state.accessToken, sessionID: state.sessionId) { [weak self] result in
                guard let self else { return }
                switch result {
                    
                case let .success(data):
                    if data.results.first?.status.first?.type.uppercased() == "SUCCESS" {
                        self.state.seqNumber = data.boardingPasses.first?.boardingPass.checkInSequenceNumber ?? "0000"
                        self.state.barCode = data.boardingPasses.first?.boardingPass.barCode ?? "0000"
                        self.state.seatNumber = data.boardingPasses.first?.boardingPass.seat?.value ?? "0000"
                        
                        self.state.displayState = .barcode
                    }
                case let .failure(error):
                    if case let .responseValidationFailed(reason) = error {
                        if case let .customValidationFailed(innerError) = reason {
                            let nsError = innerError as NSError

                            let statusCode = nsError.userInfo["statusCode"] as? Int
                            let rawBody = nsError.userInfo["rawBody"] as? String

                            // i assume that the token has expired
                            if statusCode == 401 {
                                send(.getToken(action: .checkIn))
                            }
                        }
                    }
                    
                    // force move to BarcodeView
                    state.displayState = .barcode
                }
            }
            
        case let .saveDocument(document):
            checkInService.setDocumentData(
                doc: state.document ?? Document(), //shouldn't be nill
                token: state.accessToken,
                sessionID: state.sessionId,
                passengerId: state.passengerId,
                weightCategory: (state.gender == .female ? "ADULT_FEMALE" : "ADULT_MALE")) {[weak self] result in
                    guard let self else { return }
                    switch result {
                    case let .success(data):
                        if data.results.first?.status.first?.type.uppercased() == "SUCCESS" {
                            state.displayState = .checkIn
                        }
                    case let .failure(error):
                        if case let .responseValidationFailed(reason) = error {
                            if case let .customValidationFailed(innerError) = reason {
                                let nsError = innerError as NSError

                                let statusCode = nsError.userInfo["statusCode"] as? Int
                                let rawBody = nsError.userInfo["rawBody"] as? String

                                // i assume that the token has expired
                                if statusCode == 401 {
                                    send(.getToken(action: .saveDocument(document)))
                                }
                            }
                        }
                        
                        // force move to CheckInView
                        state.displayState = .checkIn
                    }
                }
        case let .onlineCheckIn(pnr, lastName):
            state.pnr = pnr
            state.lastName = lastName
            
            send(.getDocument)
        case let .getToken(furtherAction):
            checkInService.getToken(auth: state.auth) { [weak self] result in
                guard let self else { return }
                switch result {
                case let .success(data):
                    print("access_token : \(data.access_token)")
                    self.state.accessToken = data.access_token
                    
                    if let furtherAction {
                        send(furtherAction)
                    }
                case let .failure(error):
                    print("error getToken: \(error)")
                }
            }
        case .checkInViewOnAppear:
            if state.accessToken == "" {
                send(.getToken(action: nil))
            }
        case .getDocument:
            print("state.accessToken \(state.accessToken)")
            guard !state.accessToken.isEmpty else { return }
            checkInService.getReservation(pnr: state.pnr, lastName: state.lastName, token: state.accessToken) { [weak self] result in
                guard let self else { return }
                switch result {
                case let .success(data):
                    if let passenger = data.reservation.reservation.passengers.passenger.first {
                        self.state.passengerId = passenger.id
                        self.state.firstName = passenger.personName.first
                        self.state.gender = (passenger.personName.prefix.lowercased() == "mr" ? .male : .female)
                        
                        if let document = passenger.passengerDocument.first?.document {
                            var newDocument = Document()
                            newDocument.id = document.id
                            newDocument.dateOfBirth = document.dateOfBirth ?? ""
                            newDocument.expiryDate = document.expiryDate ?? ""
                            newDocument.gender = document.gender ?? ""
                            newDocument.issuingCountry = document.issuingCountry ?? ""
                            newDocument.nationality = document.nationality ?? ""
                            newDocument.number = document.number
                            newDocument.personName = PersonName(prefix: passenger.personName.prefix, first: state.firstName, last: state.lastName)
                            self.state.document = newDocument
                        }
                        
                        state.displayState = .passengerDetails
                        state.sessionId = data.sessionID ?? ""
                        
                        if let flightDetail = data.reservation.reservation.itinerary.itineraryPart.first?.segment.first?.flightDetail.first {
                            state.flightDetail = flightDetail
                        }
                        
                    } else {
                        state.displayState = .reservationNotFound
                    }
                case let .failure(error):
                    if case let .responseValidationFailed(reason) = error {
                        if case let .customValidationFailed(innerError) = reason {
                            let nsError = innerError as NSError

                            let statusCode = nsError.userInfo["statusCode"] as? Int
                            let rawBody = nsError.userInfo["rawBody"] as? String

                            // i assume it is 'Reservation not found'
                            if statusCode == 500 {
//                                state.displayState = .reservationNotFound
                                
                                //force move to passengerDetails
                                state.displayState = .passengerDetails
                            }
                            
                            // i assume that the token has expired
                            if statusCode == 401 {
                                send(.getToken(action: .getDocument))
                            }
                        }
                    }
                }
            }
        case let .updateDisplayState(newState):
            state.displayState = newState
        }
    }
    
    func binding<Value>(_ keyPath: WritableKeyPath<State, Value>) -> Binding<Value> {
        Binding(
            get: { self.state[keyPath: keyPath] },
            set: { self.state[keyPath: keyPath] = $0 }
        )
    }
}
