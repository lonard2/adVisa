//
//  PlaneTicketData.swift
//  adVisa
//
//  Created by Lonard Steven on 13/08/24.
//

import Foundation
import SwiftData

@Model
class Document {
    @Attribute(.unique) var id: String = UUID().uuidString
    let icon: String
    let title: String
    
    init(icon: String, title: String) {
        self.icon = icon
        self.title = title
    }
}

extension SwiftDataContextManager {
    func initializeDocument() {
        do {
            documentContainer = try ModelContainer(for: Document.self)
            if let documentContainer {
                context = ModelContext(documentContainer)
            }

        } catch {
            debugPrint("Error initializing document container:", error)
        }
    }
}
