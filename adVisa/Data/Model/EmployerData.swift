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
    var employerName: Date
    var employerTelephoneNum: String
    var employerAddress: String
    
    init(employerName: Date, employerTelephoneNum: String, employerAddress: String) {
        self.employerName = employerName
        self.employerTelephoneNum = employerTelephoneNum
        self.employerAddress = employerAddress
    }
}
