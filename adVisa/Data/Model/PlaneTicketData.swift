//
//  PlaneTicketData.swift
//  adVisa
//
//  Created by Lonard Steven on 13/08/24.
//

import Foundation
import SwiftData
@Model
class PlaneTicketData {
    @Attribute(.unique) var id: String = UUID().uuidString
    var dateOfArrival: Date
    var portOfEntry: String
    var transportName: String
    
    init(dateOfArrival: Date, portOfEntry: String, transportName: String) {
        self.dateOfArrival = dateOfArrival
        self.portOfEntry = portOfEntry
        self.transportName = transportName
    }
}
