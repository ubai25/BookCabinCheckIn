//
//  NotFoundView.swift
//  BookCabin_CheckIn
//
//  Created by Ubaidillah Ahmad on 07/12/25.
//

import SwiftUI

struct NotFoundView: View {
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
              //user = UserModel()
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
    NotFoundView()
}
