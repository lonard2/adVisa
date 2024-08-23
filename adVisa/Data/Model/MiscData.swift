//
//  PlaneTicketData.swift
//  adVisa
//
//  Created by Lonard Steven on 13/08/24.
//

import Foundation
import SwiftData

@Model
class MiscData {
    @Attribute(.unique) var id: String = UUID().uuidString
    var visitPurpose: String
    var durationStay: String
    var otherNames: String
    var formerNationality: String
    var dateOfArrival: Date
    var portOfEntry: String
    var shipAirlineName: String
    
    init(visitPurpose: String, durationStay: String, otherNames: String, formerNationality: String, dateOfArrival: Date, portOfEntry: String, shipAirlineName: String) {
        self.visitPurpose = visitPurpose
        self.durationStay = durationStay
        self.otherNames = otherNames
        self.formerNationality = formerNationality
        self.dateOfArrival = dateOfArrival
        self.portOfEntry = portOfEntry
        self.shipAirlineName = shipAirlineName
    }
}
