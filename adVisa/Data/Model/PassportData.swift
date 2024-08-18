//
//  PassportData.swift
//  adVisa
//
//  Created by Lonard Steven on 13/08/24.
//

import Foundation
import SwiftData

@Model
class PassportData {
    @Attribute(.unique) var id: String
    var surname: String
    var givenName: String
    var dateOfBirth: Date
    var city: String
    var state: String
    var country: String
    var gender: GenderEnum
    var nationality: String
    var passportType: PassportTypeEnum
    var passportID: String
    var placeOfIssue: String
    var dateOfIssue: Date
    var issuingAuthority: String
    var dateOfExpiry: Date
    
    init(id:String, surname: String, givenName: String, dateOfBirth: Date, city: String, state: String, country: String, gender: GenderEnum, nationality: String, passportType: PassportTypeEnum, passportID: String, placeOfIssue: String, dateOfIssue: Date, issuingAuthority: String, dateOfExpiry: Date) {
        self.id = id
        self.surname = surname
        self.givenName = givenName
        self.dateOfBirth = dateOfBirth
        self.city = city
        self.state = state
        self.country = country
        self.gender = gender
        self.nationality = nationality
        self.passportType = passportType
        self.passportID = passportID
        self.placeOfIssue = placeOfIssue
        self.dateOfIssue = dateOfIssue
        self.issuingAuthority = issuingAuthority
        self.dateOfExpiry = dateOfExpiry
    }
    
    //Add to domain
}

extension SwiftDataContextManager {
    func initializePassportContainer() {
        do {
            passportContainer = try ModelContainer(for: PassportData.self)
            if let passportContainer {
                context = ModelContext(passportContainer)
            }

        } catch {
            debugPrint("Error initializing passport container:", error)
        }
    }
}
