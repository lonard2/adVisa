//
//  PlaneTicketData.swift
//  adVisa
//
//  Created by Lonard Steven on 13/08/24.
//

import Foundation

struct PlaneTicketData: Codable {
    var id = UUID()
    var dateOfArrival: Date
    var portOfEntry: String
    var transportName: String
}
