//
//  BoardingPassView.swift
//  BookCabin_CheckIn
//
//  Created by Ubaidillah Ahmad on 07/12/25.
//

import SwiftUI

struct BoardingPassView: View {
    @ObservedObject private var viewModel: BookCabinViewModel
    
    internal init(viewModel: BookCabinViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Boarding Pass")
                .font(.system(size: 45))
                .fontWeight(.bold)
                .foregroundStyle(Color.Secondary)
                .padding(.bottom)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.white)
            
            VStack(spacing: 0) {
                Text("\(viewModel.state.firstName) \(viewModel.state.lastName)")
                    .font(.title)
                    .foregroundStyle(Color.white)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(24)
                    .background(Color.Primary)

                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        Text(viewModel.state.flightDetail?.flightNumber ?? "0000")
                            .font(.title2)
                            .foregroundStyle(Color.Secondary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(EdgeInsets(top: 24, leading: 36, bottom: 18, trailing: 36))
                            .background(Color.Beige)
                        
                        Text("SEAT")
                            .font(.title2)
                            .foregroundStyle(Color.Secondary)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(EdgeInsets(top: 24, leading: 36, bottom: 18, trailing: 36))
                            .background(Color.Beige)
                    }
                    
                    HStack(spacing: 0) {
                        Text(viewModel.state.seqNumber)
                            .font(.system(size: 45))
                            .bold()
                            .foregroundStyle(Color.Secondary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(EdgeInsets(top: 0, leading: 36, bottom: 36, trailing: 36))
                            .background(Color.Beige)
                        
                        Text(viewModel.state.seatNumber)
                            .font(.system(size: 45))
                            .bold()
                            .foregroundStyle(Color.Secondary)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(EdgeInsets(top: 0, leading: 36, bottom: 36, trailing: 36))
                            .background(Color.Beige)
                    }
                }
            }
            .cornerRadius(24)
            
            Line()
                .stroke(style: StrokeStyle(lineWidth: 1, dash: [10, 5]))
                .frame(height: 1)
                .foregroundColor(Color.Primary)
                .padding(.init(top: 0, leading: 24, bottom: 0, trailing: 24))
            
            VStack(spacing: 0) {
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        Text(viewModel.state.flightDetail?.departureAirport ?? "N/A")
                            .font(.title2)
                            .foregroundStyle(Color.Secondary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(EdgeInsets(top: 24, leading: 36, bottom: 18, trailing: 36))
                            .background(Color.Beige)
                        
                        Text(viewModel.state.flightDetail?.arrivalAirport ?? "N/A")
                            .font(.title2)
                            .foregroundStyle(Color.Secondary)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(EdgeInsets(top: 24, leading: 36, bottom: 18, trailing: 36))
                            .background(Color.Beige)
                    }
                    
                    HStack(spacing: 0) {
                        BarcodeView(data: viewModel.state.barCode)
                            .cornerRadius(24)
                    }
                    .foregroundStyle(Color.Secondary)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(EdgeInsets(top: 0, leading: 36, bottom: 18, trailing: 36))
                    .background(Color.Beige)
                }
            }
            .cornerRadius(24)
        }
        .padding(24)
    }
}

struct Line: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        return path
    }
}

#Preview {
    BoardingPassView(viewModel: BookCabinViewModel())
}
