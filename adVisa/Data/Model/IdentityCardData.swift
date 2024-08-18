//
//  IdentityCardData.swift
//  adVisa
//
//  Created by Lonard Steven on 13/08/24.
//

import Foundation
import SwiftData

@Model
class IdentityCardData {
    @Attribute(.unique) var id: String = UUID().uuidString
    var identityId: String
    var martialStatus: MartialStatusEnum
    
    init(identityId: String, martialStatus: MartialStatusEnum) {
        self.identityId = identityId
        self.martialStatus = martialStatus
    }
}

extension SwiftDataContextManager {
    func initializeIdentityCardContainer() {
        do {
            identityCardContainer = try ModelContainer(for: IdentityCardData.self)
            if let identityCardContainer {
                context = ModelContext(identityCardContainer)
            }

        } catch {
            debugPrint("Error initializing identity card container:", error)
        }
    }
}
