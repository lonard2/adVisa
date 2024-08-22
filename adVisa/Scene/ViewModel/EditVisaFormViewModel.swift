//
//  EditVisaFormViewModel.swift
//  adVisa
//
//  Created by Dixon Willow on 21/08/24.
//

import Foundation

class EditVisaFormViewModel: ObservableObject {
    @Published var pageStep = 1
    
    //Personal Data
    
    @Published var surname = ""
    @Published var givenName = ""
    @Published var birthDate = Date()
    @Published var birthPlace = ""
    @Published var sex: GenderEnum = .male
    @Published var maritalStatus: MaritalStatusEnum = .single
    @Published var nationality = ""
    @Published var idNumber = ""
    @Published var proffesion = ""
    
    @Published var passportType: PassportTypeEnum = .ordinary
    @Published var passportNumber = ""
    @Published var passportPlaceOfIssue = ""
    @Published var passportDateOfIssue = Date()
    @Published var passportIssuingAuthority = ""
    @Published var passportExpiredDate = Date()
    
    //Visit Details
    
    @Published var purposeOfVisit = "Holiday"
    @Published var portOfEntry = ""
    @Published var shipAirplaneName = ""
    
    @Published var stayPlaceName = ""
    @Published var stayPlaceAddress = ""
    @Published var stayPlacePhoneNumber = ""
    
    func nextForm() {
        self.pageStep += 1
    }
    
    func resetFormPage() {
        self.pageStep = 1
    }
}
