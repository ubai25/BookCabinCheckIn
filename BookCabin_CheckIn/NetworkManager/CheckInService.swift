//
//  CheckInService.swift
//  BookCabin_CheckIn
//
//  Created by Ubaidillah Ahmad on 07/12/25.
//

import Foundation
import Alamofire

protocol CheckInServiceProtocol {
    func getToken(auth: String, completion: @escaping (Result<TokenResponse, AFError>) -> Void)
    func getReservation(pnr: String, lastName: String, token: String, completion: @escaping (Result<ReservationResponse, AFError>) -> Void)
}

class CheckInService: CheckInServiceProtocol {
    let baseUrl = "https://airline.api.cert.platform.sabre.com"
    
    func getReservation(pnr: String, lastName: String, token: String, completion: @escaping (Result<ReservationResponse, Alamofire.AFError>) -> Void) {
//        let url = "\(baseUrl)/v1/reservation/summary"
         let url = "\(baseUrl)/v918/dcci/passenger/details?jipcc=ODCI"
        
        // MARK: Headers
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
            "Accept": "*/*",
            "Application-ID": "SWS1:OD-DigXCI:1c8f21b5b9",
            "Content-Type": "application/json"
        ]
        
        // MARK: Body
        let body: [String: Any] = [
            "reservationCriteria": [
                "recordLocator": pnr,
                "lastName": lastName
            ],
            "outputFormat": "BPXML"
        ]
        
        // MARK: Request
        AF.request(url,
                   method: .post,
                   parameters: body,
                   encoding: JSONEncoding.default,
                   headers: headers)
        .responseData { response in
            let statusCode = response.response?.statusCode
            let rawData = response.data ?? Data()
            let rawString = String(data: rawData, encoding: .utf8)

            print("Status Code:", statusCode ?? 0)
            print("Raw Body:", rawString ?? "(empty)")

            // Check networking-level error (no internet, timeout, etc.)
            if let error = response.error {
                completion(.failure(error))
                return
            }

            if (200...299).contains(statusCode ?? 0) {
                do {
                    let decoded = try JSONDecoder().decode(ReservationResponse.self, from: rawData)
                    completion(.success(decoded))
                } catch {
                    let afError = AFError.responseSerializationFailed(reason: .decodingFailed(error: error))
                    completion(.failure(afError))
                }
                return
            }

            let apiError = AFError.responseValidationFailed(reason: .customValidationFailed(error: NSError(
                domain: "SabreAPI",
                code: statusCode ?? -1,
                userInfo: [
                    "rawBody": rawString ?? "",
                    "statusCode": statusCode ?? -1
                ]
            )))

            completion(.failure(apiError))
        }
    }
    
    func getToken(auth: String, completion: @escaping (Result<TokenResponse, Alamofire.AFError>) -> Void) {
        let url = "\(baseUrl)/v2/auth/token/"
                
        let headers: HTTPHeaders = [
            "Authorization": "Basic \(auth)",
            "Content-Type": "application/x-www-form-urlencoded",
            "Accept": "*/*",
            "Application-ID": "SWS1:OD-DigXCI:1c8f21b5b9"
        ]
        
        let parameters: Parameters = [
            "grant_type": "client_credentials"
        ]
        
        AF.request(
            url,
            method: .post,
            parameters: parameters,
            encoding: URLEncoding.default,
            headers: headers
        )
        .responseDecodable(of: TokenResponse.self) { response in
            completion(response.result)
        }
    }
}
