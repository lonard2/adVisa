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
    @Attribute(.unique) var id: String = UUID().uuidString
    var surname: String
    var givenName: String
    var dateOfBirth: Date
    var city: String
    var state: String
    var country: String
    var gender: GenderEnum
    var maritalStatus: MartialStatusEnum
    var nationality: String
    var passportType: PassportTypeEnum
    var passportID: String
    var placeOfIssue: String
    var dateOfIssue: Date
    var issuingAuthority: String
    var dateOfExpiry: Date
    
    init(surname: String, givenName: String, dateOfBirth: Date, city: String, state: String, country: String, gender: GenderEnum, martialStatus: MartialStatusEnum, nationality: String, passportType: PassportTypeEnum, passportID: String, placeOfIssue: String, dateOfIssue: Date, issuingAuthority: String, dateOfExpiry: Date) {
        self.surname = surname
        self.givenName = givenName
        self.dateOfBirth = dateOfBirth
        self.city = city
        self.state = state
        self.country = country
        self.gender = gender
        self.maritalStatus = martialStatus
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
