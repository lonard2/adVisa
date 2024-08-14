//
//  PlaneTicketData.swift
//  adVisa
//
//  Created by Lonard Steven on 13/08/24.
//

import Foundation

struct CrimeRemarkData: Codable {
    var id = UUID()
    var haveCrimeConvicted: Bool
    var haveImprisonedOneYear: Bool
    var haveDeported: Bool
    var haveDrugOffence: Bool
    var haveIllictOffence: Bool
    var haveTraffickingOffence: Bool
    
    var relevantDetails: String
}
