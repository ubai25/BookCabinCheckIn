//
//  ReservationResponse.swift
//  BookCabin_CheckIn
//
//  Created by Ubaidillah Ahmad on 07/12/25.
//

import Foundation

// MARK: - Root
struct ReservationResponse: Codable {
    let reservation: Reservation
}

struct Reservation: Codable {
    let passengers: Passengers
    let itinerary: Itinerary
}

// MARK: - Passengers
struct Passengers: Codable {
    let passenger: [Passenger]
}

struct Passenger: Codable {
    let id: String
    let personName: PersonName
    let passengerDocument: [PassengerDocumentContainer]
}

// MARK: - Passenger Document
struct PassengerDocumentContainer: Codable {
    let document: PassengerDocument
}

struct PassengerDocument: Codable {
    let id: String
    let number: String
    let personName: DocumentPersonName?
    let nationality: String?
    let dateOfBirth: String?
    let issuingCountry: String?
    let expiryDate: String?
    let gender: String?
    let type: String?
}

struct DocumentPersonName: Codable {
    let first: String
    let last: String
}

// MARK: - Itinerary
struct Itinerary: Codable {
    let itineraryPart: [ItineraryPart]
}

struct ItineraryPart: Codable {
    let segment: [Segment]
}

struct Segment: Codable {
    let flightDetail: [FlightDetail]
}

// MARK: - Flight Details
struct FlightDetail: Codable {
    let flightNumber: String
    let arrivalAirport: String
    let departureAirport: String
}
