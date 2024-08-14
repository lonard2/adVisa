//
//  PlaneTicketData.swift
//  adVisa
//
//  Created by Lonard Steven on 13/08/24.
//

import Foundation
import SwiftData
@Model
class TravelHistoryData {
    @Attribute(.unique) var id: String = UUID().uuidString
    var travelDate: Date
    var travelDuration: String
    var travelType: String
    
    init(travelDate: Date, travelDuration: String, travelType: String) {
        self.travelDate = travelDate
        self.travelDuration = travelDuration
        self.travelType = travelType
    }
}

extension SwiftDataContextManager {
    func initializeTravelHistoryContainer() {
        do {
            travelHistoryContainer = try ModelContainer(for: TravelHistoryData.self)
            if let travelHistoryContainer {
                context = ModelContext(travelHistoryContainer)
            }

        } catch {
            debugPrint("Error initializing travel history container:", error)
        }
    }
}
