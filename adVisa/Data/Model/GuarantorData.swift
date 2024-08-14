//
//  PlaneTicketData.swift
//  adVisa
//
//  Created by Lonard Steven on 13/08/24.
//

import Foundation

struct GuarantorData: Codable {
    var id = UUID()
    var guarantorName: String
    var guarantorTelephoneNum: String
    var guarantorAddress: String
    var guarantorDoB: Date
    var guarantorGender: GenderEnum
    var guarantorRelationship: String
    var guarantorOccupation: String
    var guarantorPosition: String
    var guarantorNationality: String
    var guarantorImmigrationStatus: String
}
