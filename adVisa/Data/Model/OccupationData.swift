//
//  PlaneTicketData.swift
//  adVisa
//
//  Created by Lonard Steven on 13/08/24.
//

import Foundation

struct OccupationData: Codable {
    var id = UUID()
    var occupationData: String
    var positionData: String
    var employerName: String
}
