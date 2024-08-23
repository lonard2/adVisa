//
//  PlaneTicketData.swift
//  adVisa
//
//  Created by Lonard Steven on 13/08/24.
//

import Foundation
import SwiftData

@Model
class DomicileData {
    @Attribute(.unique) var id: String = UUID().uuidString
    var currentPhoneNum: String
    var currentTelephoneNum: String?
    var currentEmail: String
    
    init(currentPhoneNum: String, currentTelephoneNum: String? = nil, currentEmail: String) {
        self.currentPhoneNum = currentPhoneNum
        self.currentTelephoneNum = currentTelephoneNum
        self.currentEmail = currentEmail
    }
}
