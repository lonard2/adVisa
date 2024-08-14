//
//  PlaneTicketData.swift
//  adVisa
//
//  Created by Lonard Steven on 13/08/24.
//

import Foundation

struct InviterData: Codable {
    var id = UUID()
    var inviterName: String
    var inviterTelephoneNum: String
    var inviterAddress: String
    var inviterDoB: Date
    var inviterGender: GenderEnum
    var inviterRelationship: String
    var inviterOccupation: String
    var inviterPosition: String
    var inviterNationality: String
    var inviterImmigrationStatus: String
}
