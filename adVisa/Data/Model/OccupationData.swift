//
//  PlaneTicketData.swift
//  adVisa
//
//  Created by Lonard Steven on 13/08/24.
//

import Foundation
import SwiftData

@Model
class OccupationData {
    @Attribute(.unique) var id: String = UUID().uuidString
    var occupationData: String
    var positionData: String
    var employerName: String
    
    init(occupationData: String, positionData: String, employerName: String) {
        self.occupationData = occupationData
        self.positionData = positionData
        self.employerName = employerName
    }
}

extension SwiftDataContextManager {
    func initializeOccupationContainer() {
        do {
            occupationContainer = try ModelContainer(for: OccupationData.self)
            if let occupationContainer {
                context = ModelContext(occupationContainer)
            }

        } catch {
            debugPrint("Error initializing occupation container:", error)
        }
    }
}
