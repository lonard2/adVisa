//
//  TopDestination.swift
//  adVisa
//
//  Created by Dixon Willow on 21/08/24.
//

import Foundation

class TopDestination: Identifiable {
    let id = UUID().uuidString
    var countryName: String
    var countryImage: String
    var rank: String
    
    init(countryName: String, countryImage: String, rank: String) {
        self.countryName = countryName
        self.countryImage = countryImage
        self.rank = rank
    }
}
