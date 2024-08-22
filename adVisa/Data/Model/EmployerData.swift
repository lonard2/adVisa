//
//  PlaneTicketData.swift
//  adVisa
//
//  Created by Lonard Steven on 13/08/24.
//

import Foundation
import SwiftData

@Model
class EmployerData {
    @Attribute(.unique) var id: String = UUID().uuidString
    var employerName: String
    var employerTelephoneNum: String
    var employerAddress: String
    
    init(id: String, employerName: String, employerTelephoneNum: String, employerAddress: String) {
        self.id = id
        self.employerName = employerName
        self.employerTelephoneNum = employerTelephoneNum
        self.employerAddress = employerAddress
    }
}
