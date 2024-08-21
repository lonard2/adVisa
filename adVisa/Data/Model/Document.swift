//
//  PlaneTicketData.swift
//  adVisa
//
//  Created by Lonard Steven on 13/08/24.
//

import Foundation

class Document: Identifiable {
    let id = UUID().uuidString
    let icon: String
    let title: String
    
    init(icon: String, title: String) {
        self.icon = icon
        self.title = title
    }
}
