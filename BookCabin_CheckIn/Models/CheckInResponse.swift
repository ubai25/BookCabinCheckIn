//
//  CheckInResponse.swift
//  BookCabin_CheckIn
//
//  Created by Ubaidillah Ahmad on 08/12/25.
//

import Foundation

struct CheckInResponse: Codable {
    let boardingPasses: [BoardingPassWrapper]
    let results: [BoardingPassResult]
}

struct BoardingPassWrapper: Codable {
    let boardingPass: BoardingPassDetail
}

struct BoardingPassDetail: Codable {
    let checkInSequenceNumber: String
    let barCode: String
    let seat: Seat?
}

struct Seat: Codable {
    let value: String
}

struct BoardingPassResult: Codable {
    let status: [StatusType]
    let passengerFlightRef: String
}

struct StatusType: Codable {
    let type: String
}
