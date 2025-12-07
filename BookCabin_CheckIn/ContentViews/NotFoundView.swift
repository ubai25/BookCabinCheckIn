//
//  NotFoundView.swift
//  BookCabin_CheckIn
//
//  Created by Ubaidillah Ahmad on 07/12/25.
//

import SwiftUI

struct NotFoundView: View {
    @ObservedObject private var viewModel: BookCabinViewModel
    
    internal init(viewModel: BookCabinViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            Text("RESERVATION NOT FOUND")
                .font(.system(size: 40))
                .fontWeight(.heavy)
                .foregroundStyle(Color.Secondary)
                .padding(.bottom)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.white)
            
            Spacer()
            
            Button("BACK") {
                viewModel.send(.updateDisplayState(.onlineCheckIn))
            }
            .foregroundStyle(.white)
            .bold()
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.Primary)
            .cornerRadius(8)
        }
        .padding(36)
    }
}

#Preview {
    NotFoundView(viewModel: BookCabinViewModel())
}
