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
    var specialRemark: String
    var dateOfApplication: Date
    
    init(visitPurpose: String, specialRemark: String, dateOfApplication: Date) {
        self.visitPurpose = visitPurpose
        self.specialRemark = specialRemark
        self.dateOfApplication = dateOfApplication
    }
}

extension SwiftDataContextManager {
    func initializeMiscContainer() {
        do {
            miscContainer = try ModelContainer(for: MiscData.self)
            if let miscContainer {
                context = ModelContext(miscContainer)
            }

        } catch {
            debugPrint("Error initializing misc container:", error)
        }
    }
}
