//
//  SwiftDataContextManager.swift
//  adVisa
//
//  Created by hendra on 14/08/24.
//

import Foundation
import SwiftData

public class SwiftDataContextManager {
    public static var shared = SwiftDataContextManager()
    
    var container: ModelContainer?
    
    var context: ModelContext?

    init() {
        do {
            container = try ModelContainer(for: PassportData.self, IdentityCardData.self, PlaneTicketData.self, DomicileData.self, TravelHistoryData.self, EmployerData.self, OccupationData.self, GuarantorData.self, InviterData.self, MiscData.self, CrimeRemarkData.self)
            if let container {
                context = ModelContext(container)
            }
        } catch {
            debugPrint("Error initializing database container:", error)
        }
    }
}
