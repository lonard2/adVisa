//
//  PlaneTicketData.swift
//  adVisa
//
//  Created by Lonard Steven on 13/08/24.
//

import Foundation

struct MiscData: Codable {
    var id = UUID()
    var visitPurpose: String
    var specialRemark: String
    
    var dateOfApplication: Date
}
