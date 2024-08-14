//
//  PlaneTicketData.swift
//  adVisa
//
//  Created by Lonard Steven on 13/08/24.
//

import Foundation
import SwiftData

@Model
class CrimeRemarkData {
    @Attribute(.unique) var id: String = UUID().uuidString
    var haveCrimeConvicted: Bool
    var haveImprisonedOneYear: Bool
    var haveDeported: Bool
    var haveDrugOffence: Bool
    var haveIllictOffence: Bool
    var haveTraffickingOffence: Bool
    var relevantDetails: String
    
    init(haveCrimeConvicted: Bool, haveImprisonedOneYear: Bool, haveDeported: Bool, haveDrugOffence: Bool, haveIllictOffence: Bool, haveTraffickingOffence: Bool, relevantDetails: String) {
        self.haveCrimeConvicted = haveCrimeConvicted
        self.haveImprisonedOneYear = haveImprisonedOneYear
        self.haveDeported = haveDeported
        self.haveDrugOffence = haveDrugOffence
        self.haveIllictOffence = haveIllictOffence
        self.haveTraffickingOffence = haveTraffickingOffence
        self.relevantDetails = relevantDetails
    }
}

extension SwiftDataContextManager {
    func initializeCrimeRemarkContainer() {
        do {
            crimeRemarkContainer = try ModelContainer(for: CrimeRemarkData.self)
            if let crimeRemarkContainer {
                context = ModelContext(crimeRemarkContainer)
            }

        } catch {
            debugPrint("Error initializing crime remark container:", error)
        }
    }
}
