//
//  PlaneTicketData.swift
//  adVisa
//
//  Created by Lonard Steven on 13/08/24.
//

import Foundation

class Document: Identifiable {
    let id = UUID().uuidString
    var icon: String
    var imageName: String
    var documentName: String
    var explanation: String
    
    init(icon: String, imageName: String, documentName: String, explanation: String) {
        self.icon = icon
        self.imageName = imageName
        self.documentName = documentName
        self.explanation = explanation
    }
}
