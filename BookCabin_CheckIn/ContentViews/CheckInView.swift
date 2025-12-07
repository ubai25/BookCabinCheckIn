//
//  CheckInView.swift
//  BookCabin_CheckIn
//
//  Created by Ubaidillah Ahmad on 07/12/25.
//

import SwiftUI

struct CheckInView: View {
    @ObservedObject private var viewModel: BookCabinViewModel
    
    internal init(viewModel: BookCabinViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            Text("CHECK-IN")
                .font(.system(size: 50))
                .fontWeight(.heavy)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 36)
            
            Text("\(viewModel.state.firstName) \(viewModel.state.lastName)")
                .font(.largeTitle)
                .bold()
                .foregroundStyle(Color.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 24)
            
            Text("\(viewModel.state.flightDetail?.flightNumber ?? "") \(viewModel.state.flightDetail?.departureAirport ?? "") to \(viewModel.state.flightDetail?.arrivalAirport ?? "")")
                .font(.title2)
                .foregroundStyle(Color.white)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            
            Button("CHECK IN") {
                viewModel.send(.checkIn)
            }
            .foregroundStyle(.white)
            .font(.largeTitle)
            .bold()
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.Primary)
            .cornerRadius(8)
        }
        .padding(24)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.Secondary)
    }
}

#Preview {
    CheckInView(viewModel: BookCabinViewModel())
}
