//
//  PlaneTicketData.swift
//  adVisa
//
//  Created by Lonard Steven on 13/08/24.
//

import Foundation

struct TravelHistoryData: Codable {
    var id = UUID()
    var travelDate: Date
    var travelDuration: String
    var travelType: String
}
