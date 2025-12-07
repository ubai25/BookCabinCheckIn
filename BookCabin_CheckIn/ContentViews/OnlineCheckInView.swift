//
//  OnlineCheckInView.swift
//  BookCabin_CheckIn
//
//  Created by Ubaidillah Ahmad on 07/12/25.
//

import SwiftUI

struct OnlineCheckInView: View {
    @State private var pnr = ""
    @State private var lastName = ""
    
    var body: some View {
        VStack {
            Text("ONLINE CHECK IN")
                .font(.largeTitle)
                .bold()
                .foregroundStyle(.white)
                .padding(.top, 100)
            
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
//                user = UserModel()
            }
            .foregroundStyle(.white)
            .bold()
            .frame(width: 200)
            .padding()
            .background(Color.Primary)
            .cornerRadius(8)
            .padding(.bottom, 100)
        }
        .padding(24)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.Secondary)
        .ignoresSafeArea()
    }
}

#Preview {
    OnlineCheckInView()
}
