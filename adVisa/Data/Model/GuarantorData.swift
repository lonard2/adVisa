//
//  PlaneTicketData.swift
//  adVisa
//
//  Created by Lonard Steven on 13/08/24.
//

import Foundation
import SwiftData

@Model
class GuarantorData {
    @Attribute(.unique) var id: String = UUID().uuidString
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
    
    init(guarantorName: String, guarantorTelephoneNum: String, guarantorAddress: String, guarantorDoB: Date, guarantorGender: GenderEnum, guarantorRelationship: String, guarantorOccupation: String, guarantorPosition: String, guarantorNationality: String, guarantorImmigrationStatus: String) {
        self.guarantorName = guarantorName
        self.guarantorTelephoneNum = guarantorTelephoneNum
        self.guarantorAddress = guarantorAddress
        self.guarantorDoB = guarantorDoB
        self.guarantorGender = guarantorGender
        self.guarantorRelationship = guarantorRelationship
        self.guarantorOccupation = guarantorOccupation
        self.guarantorPosition = guarantorPosition
        self.guarantorNationality = guarantorNationality
        self.guarantorImmigrationStatus = guarantorImmigrationStatus
    }
}
