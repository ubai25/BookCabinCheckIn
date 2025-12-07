//
//  OnlineCheckInView.swift
//  BookCabin_CheckIn
//
//  Created by Ubaidillah Ahmad on 07/12/25.
//

import SwiftUI

struct OnlineCheckInView: View {
    @ObservedObject private var viewModel: BookCabinViewModel
    @State private var pnr = ""
    @State private var lastName = ""
    
    internal init(viewModel: BookCabinViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            Text("ONLINE CHECK IN")
                .font(.system(size: 50))
                .fontWeight(.heavy)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 36)
            
            Spacer()
            
            Text("PNR")
                .font(.title2)
                .bold()
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            TextField("PNR", text: $pnr)
                .padding(.horizontal)
                .frame(minHeight: 50)
                .background(Color.white)
                .cornerRadius(8)
            
            Text("Last Name")
                .font(.title2)
                .bold()
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            TextField("LastName", text: $lastName)
                .padding(.horizontal)
                .frame(minHeight: 50)
                .background(Color.white)
                .cornerRadius(8)
            
            Spacer()
            
            Button("CHECK IN") {
                viewModel.send(.checkIn(pnr: pnr, lastName: lastName))
            }
            .foregroundStyle(.white)
            .bold()
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.Primary)
            .cornerRadius(8)
            .padding(.top, 50)
        }
        .padding(24)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.Secondary)
        .onAppear {
            viewModel.send(.checkInViewOnAppear)
        }
    }
}

#Preview {
    OnlineCheckInView(viewModel: BookCabinViewModel())
}
