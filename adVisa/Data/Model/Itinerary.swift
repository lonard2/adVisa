//
//  Itinerary.swift
//  adVisa
//
//  Created by Dixon Willow on 20/08/24.
//

import Foundation

class Itinerary: Identifiable {
    let id = UUID().uuidString
    var date: Date
    var placeToVisit: String
    var placeToStay: String
    
    init(date: Date, placeToVisit: String, placeToStay: String) {
        self.date = date
        self.placeToVisit = placeToVisit
        self.placeToStay = placeToStay
    }
}
