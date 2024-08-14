//
//  PlaneTicketData.swift
//  adVisa
//
//  Created by Lonard Steven on 13/08/24.
//

import Foundation
import SwiftData

@Model
class InviterData {
    @Attribute(.unique) var id: String = UUID().uuidString
    var inviterName: String
    var inviterTelephoneNum: String
    var inviterAddress: String
    var inviterDoB: Date
    var inviterGender: GenderEnum
    var inviterRelationship: String
    var inviterOccupation: String
    var inviterPosition: String
    var inviterNationality: String
    var inviterImmigrationStatus: String
    
    init(inviterName: String, inviterTelephoneNum: String, inviterAddress: String, inviterDoB: Date, inviterGender: GenderEnum, inviterRelationship: String, inviterOccupation: String, inviterPosition: String, inviterNationality: String, inviterImmigrationStatus: String) {
        self.inviterName = inviterName
        self.inviterTelephoneNum = inviterTelephoneNum
        self.inviterAddress = inviterAddress
        self.inviterDoB = inviterDoB
        self.inviterGender = inviterGender
        self.inviterRelationship = inviterRelationship
        self.inviterOccupation = inviterOccupation
        self.inviterPosition = inviterPosition
        self.inviterNationality = inviterNationality
        self.inviterImmigrationStatus = inviterImmigrationStatus
    }
}

extension SwiftDataContextManager {
    func initializeInviterContainer() {
        do {
            inviterContainer = try ModelContainer(for: InviterData.self)
            if let inviterContainer {
                context = ModelContext(inviterContainer)
            }

        } catch {
            debugPrint("Error initializing inviter container:", error)
        }
    }
}
