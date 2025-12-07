//
//  DocumentUpdateRequest.swift
//  BookCabin_CheckIn
//
//  Created by Ubaidillah Ahmad on 07/12/25.
//

import Foundation

struct DocumentUpdateRequest: Codable {
    let returnSession: Bool
    let passengerDetails: [PassengerDetail]
}

struct PassengerDetail: Codable {
    let documents: [DocumentWrapper]
    let weightCategory: String
    let passengerId: String
}

struct DocumentWrapper: Codable {
    let document: Document
}
