//
//  RootView.swift
//  BookCabin_CheckIn
//
//  Created by Ubaidillah Ahmad on 07/12/25.
//

import SwiftUI

struct RootView: View {
    @StateObject private var viewModel = BookCabinViewModel()
    var body: some View {
        switch viewModel.state.displayState {
        case .onlineCheckIn:
            OnlineCheckInView(viewModel: viewModel)
        case .reservationNotFound:
            PassengerDetailsView()
        case .passengerDetails:
            PassengerDetailsView()
        case .checkIn:
            CheckInView()
        case .barcode:
            BoardingPassView()
        }
    }
}

#Preview {
    RootView()
}
