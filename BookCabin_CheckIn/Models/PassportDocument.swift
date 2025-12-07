//
//  PassportDocument.swift
//  BookCabin_CheckIn
//
//  Created by Ubaidillah Ahmad on 07/12/25.
//

import Foundation

struct Document: Codable {
    var number: String = ""
    var personName: PersonName = PersonName()
    var nationality: String = ""
    var countryOfBirth: String = ""
    var dateOfBirth: String = ""
    var issuingCountry: String = ""
    var issuingPlace: String = ""
    var issueDate: String = ""
    var expiryDate: String = ""
    var gender: String = ""
    var id: String = ""
    var type: String = ""
}

struct PersonName: Codable {
    var prefix: String = ""
    var first: String = ""
    var last: String = ""
}
