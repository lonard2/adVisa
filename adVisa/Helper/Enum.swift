//
//  Enum.swift
//  adVisa
//
//  Created by Lonard Steven on 14/08/24.
//

import Foundation

enum GenderEnum: String, Codable {
    case male, female
}

enum MaritalStatusEnum: String, Codable {
    case single, married, divorced, widowed
}

enum PassportTypeEnum: String, Codable {
    case diplomatic, official, ordinary, other
}

enum DocumentRequirementConstants {
    case awayTicket, boardingTicket, accomodation, bankStatement
}

enum DocumentType {
    case ktp, passport, hotel, tiket_pesawat, none
}

enum DocumentTypeDetailed {
    case ktp, passport_bio, passport_endorsement, self_portrait, generic, none
}
