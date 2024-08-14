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
    
    init(identityId: String) {
        self.identityId = identityId
    }
}
