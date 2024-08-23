//
//  DepartureFlightData.swift
//  adVisa
//
//  Created by hendra on 23/08/24.
//

import Foundation
import SwiftData

@Model
class DepartureFlightData {
    @Attribute(.unique) var id: String
    var airlines: String
    var to: String
    var from: String
    
    init(id: String, airlines: String, to: String, from: String) {
        self.id = id
        self.airlines = airlines
        self.to = to
        self.from = from
    }
}
