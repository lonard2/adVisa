//
//  PlaneTicketData.swift
//  adVisa
//
//  Created by Lonard Steven on 13/08/24.
//

import Foundation

struct DomicileData: Codable {
    var id = UUID()
    var currentAddress: String
    var currentPhoneNum: String
    var currentTelephoneNum: String
    var currentEmail: String
}
