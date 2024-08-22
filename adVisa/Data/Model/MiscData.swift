//
//  PlaneTicketData.swift
//  adVisa
//
//  Created by Lonard Steven on 13/08/24.
//

import Foundation
import SwiftData

@Model
class MiscData {
    @Attribute(.unique) var id: String = UUID().uuidString
    var visitPurpose: String
    var specialRemark: String
    var durationStay: String
    var dateOfApplication: Date
    
    init(id: String, visitPurpose: String, specialRemark: String, durationStay: String, dateOfApplication: Date) {
        self.id = id
        self.visitPurpose = visitPurpose
        self.specialRemark = specialRemark
        self.durationStay = durationStay
        self.dateOfApplication = dateOfApplication
    }
}
