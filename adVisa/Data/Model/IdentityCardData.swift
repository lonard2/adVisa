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
    var maritalStatus: MaritalStatusEnum
    
    init(id: String, identityId: String, maritalStatus: MaritalStatusEnum) {
        self.id = id
        self.identityId = identityId
        self.maritalStatus = maritalStatus
    }
}
