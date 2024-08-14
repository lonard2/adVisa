//
//  PlaneTicketData.swift
//  adVisa
//
//  Created by Lonard Steven on 13/08/24.
//

import Foundation
import SwiftData
@Model
class TravelHistoryData {
    @Attribute(.unique) var id: String = UUID().uuidString
    var travelDate: Date
    var travelDuration: String
    var travelType: String
    
    init(travelDate: Date, travelDuration: String, travelType: String) {
        self.travelDate = travelDate
        self.travelDuration = travelDuration
        self.travelType = travelType
    }
}
