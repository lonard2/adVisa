//
//  AccomodationData.swift
//  adVisa
//
//  Created by hendra on 22/08/24.
//

import Foundation
import SwiftData
@Model
class AccomodationData {
    @Attribute(.unique) var id: String = UUID().uuidString
    var name: String
    var address: String
    var telephoneNum: String
    
    init(id: String, name: String, address: String, telephoneNum: String) {
        self.id = id
        self.name = name
        self.address = address
        self.telephoneNum = telephoneNum
    }
}
