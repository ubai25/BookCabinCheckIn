//
//  PassengerDetailsView.swift
//  BookCabin_CheckIn
//
//  Created by Ubaidillah Ahmad on 07/12/25.
//

import SwiftUI

struct PassengerDetailsView: View {
    @State private var dummy = ""
    @State private var dummyDate: Date = Date()
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Passenger Details")
                    .font(.system(size: 40))
                    .fontWeight(.heavy)
                    .foregroundStyle(Color.Secondary)
                    .padding(.bottom)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(.white)
                
                Text("Ahmad Ubaidillah")
                    .font(.title)
                    .bold()
                    .foregroundStyle(Color.Secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("SQ 267 Singapore to Tokyo")
                    .font(.title2)
                    .foregroundStyle(Color.Secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Passport information is required")
                    .font(.title2)
                    .bold()
                    .foregroundStyle(.white)
                    .padding()
                    .frame(maxWidth: .infinity, minHeight: 100, alignment: .leading)
                    .background(Color.Primary)
                    .cornerRadius(8)
                    .padding(.vertical)
                
                Text("Please enter ite required documents details below")
                    .font(.title2)
                    .foregroundStyle(Color.Secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom)
                
                Text("Passport Number")
                    .passengerDetailsTextStyle()
                
                TextField("Passport Number", text: $dummy)
                    .passengerDetailsTextFieldStyle()
                    .padding(.bottom)
                
                Text("Passenger Name")
                    .passengerDetailsTextStyle()
                
                TextField("First Name", text: $dummy)
                    .passengerDetailsTextFieldStyle()
                
                TextField("Last Name", text: $dummy)
                    .passengerDetailsTextFieldStyle()
                    .padding(.bottom)
                
                Text("Nationality")
                    .passengerDetailsTextStyle()
                
                TextField("Nationality", text: $dummy)
                    .passengerDetailsTextFieldStyle()
                    .padding(.bottom)
                
                HStack(alignment: .center) {
                    Text("Gender")
                        .passengerDetailsTextStyle()
                    
                    Picker("Flavor", selection: $dummy) {
                        Text("MALE").tag("MALE")
                        Text("FEMALE").tag("FEMALE")
                    }
                    .pickerStyle(.menu)
                    .passengerDetailsTextFieldStyle()
                }
                .padding(.bottom)
                
                Text("Country Of Birth")
                    .passengerDetailsTextStyle()
                
                TextField("Country Of Birth", text: $dummy)
                    .passengerDetailsTextFieldStyle()
                    .padding(.bottom)
                
                DatePicker("Date of Birth", selection: $dummyDate, displayedComponents: .date)
                    .font(.title3)
                    .bold()
                    .padding(.bottom)
                
                Text("Issuing Country")
                    .passengerDetailsTextStyle()

                TextField("Issuing Country", text: $dummy)
                    .passengerDetailsTextFieldStyle()
                    .padding(.bottom)
                
                Text("Issuing Place")
                    .passengerDetailsTextStyle()

                TextField("Issuing Place", text: $dummy)
                    .passengerDetailsTextFieldStyle()
                    .padding(.bottom)
                
                DatePicker("Issue Date", selection: $dummyDate, displayedComponents: .date)
                    .font(.title3)
                    .bold()
                    .padding(.bottom)
                
                DatePicker("Expiry Date", selection: $dummyDate, displayedComponents: .date)
                    .font(.title3)
                    .bold()
                    .padding(.bottom)
                
                Button("SAVE") {
                  //user = UserModel()
                }
                .foregroundStyle(.white)
                .bold()
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.Primary)
                .cornerRadius(8)
            }
        }
        .scrollIndicators(.hidden)
        .padding(24)
    }
}

fileprivate extension View {
    func passengerDetailsTextFieldStyle() -> some View {
        self
            .padding(.horizontal)
            .frame(minHeight: 50)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.Secondary, lineWidth: 1)
            )
            .cornerRadius(8)
    }
    
    func passengerDetailsTextStyle() -> some View {
        self
            .font(.title3)
            .bold()
            .foregroundStyle(Color.Secondary)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    PassengerDetailsView()
}

