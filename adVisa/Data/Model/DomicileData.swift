//
//  PlaneTicketData.swift
//  adVisa
//
//  Created by Lonard Steven on 13/08/24.
//

import Foundation
import SwiftData
@Model
class DomicileData {
    @Attribute(.unique) var id: String = UUID().uuidString
    var currentAddress: String
    var currentPhoneNum: String
    var currentTelephoneNum: String
    var currentEmail: String
    
    init(currentAddress: String, currentPhoneNum: String, currentTelephoneNum: String, currentEmail: String) {
        self.currentAddress = currentAddress
        self.currentPhoneNum = currentPhoneNum
        self.currentTelephoneNum = currentTelephoneNum
        self.currentEmail = currentEmail
    }
}

extension SwiftDataContextManager {
    func initializeDomicileContainer() {
        do {
            domicileContainer = try ModelContainer(for: DomicileData.self)
            if let domicileContainer {
                context = ModelContext(domicileContainer)
            }

        } catch {
            debugPrint("Error initializing domicile container:", error)
        }
    }
}
