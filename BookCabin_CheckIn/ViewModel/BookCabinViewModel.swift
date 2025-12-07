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
        var displayState: DisplayState = .onlineCheckIn
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
        case onlineCheckIn
        case getDocument
        case saveDocument
        case checkIn(pnr: String, lastName: String)
    }

    func send(_ action: Action) {
        reducer(action)
    }

    private func reducer(_ action: Action) {
        switch action {
            
        case .onlineCheckIn:
            // code
            print("")
        case .saveDocument:
            // code
            print("")
        case let .checkIn(pnr, lastName):
            state.pnr = pnr
            state.lastName = lastName
            
            send(.getDocument)
        case .getToken:
            checkInService.getToken(auth: state.auth) { [weak self] result in
                guard let self else { return }
                switch result {
                case let .success(data):
                    print("access_token : \(data.access_token)")
                    self.state.accessToken = data.access_token
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
                    if let passenger = data.reservation.passengers.passenger.first {
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
                    } else {
                        state.displayState = .reservationNotFound
                    }
                case let .failure(error):
                    if case let .responseValidationFailed(reason) = error {
                        if case let .customValidationFailed(innerError) = reason {
                            let nsError = innerError as NSError

                            let statusCode = nsError.userInfo["statusCode"] as? Int
                            let rawBody = nsError.userInfo["rawBody"] as? String

                            // i assume it is Reservation not found
                            if statusCode == 500 {
                                state.displayState = .reservationNotFound
                            }
                            
                            // i assume the token is expired
                            if statusCode == 401 {
                                send(.getToken(action: .getDocument))
                            }
                        }
                    }
                }
            }
        }
    }
    
    func binding<Value>(_ keyPath: WritableKeyPath<State, Value>) -> Binding<Value> {
        Binding(
            get: { self.state[keyPath: keyPath] },
            set: { self.state[keyPath: keyPath] = $0 }
        )
    }
}
