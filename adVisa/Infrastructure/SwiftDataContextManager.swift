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
    var passportContainer: ModelContainer?
    var context: ModelContext?

    init() {
        do {
            passportContainer = try ModelContainer(for: PassportData.self)
            if let container {
                context = ModelContext(container)
            }
        } catch {
            debugPrint("Error initializing database container:", error)
        }
    }
}
