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
            NotFoundView(viewModel: viewModel)
        case .passengerDetails:
            PassengerDetailsView(viewModel: viewModel)
        case .checkIn:
            CheckInView(viewModel: viewModel)
        case .barcode:
            BoardingPassView(viewModel: viewModel)
        }
    }
}

#Preview {
    RootView()
}
