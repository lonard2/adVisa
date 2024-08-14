//
//  PassportData.swift
//  adVisa
//
//  Created by Lonard Steven on 13/08/24.
//

import Foundation

enum GenderEnum: String, Codable {
    case male, female
}

enum MartialStatusEnum: String, Codable {
    case single, married, divorced
}

enum PassportTypeEnum: String, Codable {
    case diplomatic, official, ordinary, other
}

struct PassportData: Codable {
    var id = UUID()
    var surname: String
    var givenName: String
    var dateOfBirth: Date
    var city: String
    var state: String
    var country: String
    var gender: GenderEnum
    var martialStatus: MartialStatusEnum
    var nationality: String
    var passportType: PassportTypeEnum
    var passportID: String
    var placeOfIssue: String
    var dateOfIssue: Date
    var issuingAuthority: String
    var dateOfExpiry: Date
}
