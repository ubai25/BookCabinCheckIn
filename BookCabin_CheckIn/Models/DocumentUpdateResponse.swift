//
//  DocumentUpdateResponse.swift
//  BookCabin_CheckIn
//
//  Created by Ubaidillah Ahmad on 07/12/25.
//

import Foundation

struct DocumentUpdateResponse: Codable {
    let results: [UpdateResult]
}

struct UpdateResult: Codable {
    let status: [StatusInfo]
}

struct StatusInfo: Codable {
    let type: String
}
