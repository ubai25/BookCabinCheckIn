//
//  TokenResponse.swift
//  BookCabin_CheckIn
//
//  Created by Ubaidillah Ahmad on 07/12/25.
//

import Foundation

struct TokenResponse: Decodable {
    let access_token: String
    let token_type: String
    let expires_in: Int
}
