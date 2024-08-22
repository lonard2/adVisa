//
//  Itinerary.swift
//  adVisa
//
//  Created by Dixon Willow on 20/08/24.
//

import Foundation
import SwiftData

@Model
class Itinerary {
    @Attribute(.unique) var id: String = UUID().uuidString
    let date: Date
    let placeToVisit: String
    let placeToStay: String
    
    init(date: Date, placeToVisit: String, placeToStay: String) {
        self.date = date
        self.placeToVisit = placeToVisit
        self.placeToStay = placeToStay
    }
}
