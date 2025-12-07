//
//  CheckInView.swift
//  BookCabin_CheckIn
//
//  Created by Ubaidillah Ahmad on 07/12/25.
//

import SwiftUI

struct CheckInView: View {
//    let viewModel = 
    var body: some View {
        VStack {
            Text("CHECK-IN")
                .font(.system(size: 50))
                .fontWeight(.heavy)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 36)
            
            Text("Ahmad Ubaidillah")
                .font(.largeTitle)
                .bold()
                .foregroundStyle(Color.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 24)
            
            Text("SQ 267 Singapore to Tokyo")
                .font(.title2)
                .foregroundStyle(Color.white)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            
            Button("CHECK IN") {
              //user = UserModel()
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
    CheckInView()
}
