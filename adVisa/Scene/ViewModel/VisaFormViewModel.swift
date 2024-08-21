//
//  VisaFormViewModel.swift
//  adVisa
//
//  Created by Dixon Willow on 20/08/24.
//

import Foundation

class VisaFormViewModel: ObservableObject {
    @Published var pageStep = 1
    
    @Published var hasOtherName = false
    @Published var otherName = ""
    
    @Published var hasPriorNationality = false
    @Published var priorNationality = ""
    
    @Published var hasOtherNationality = false
    @Published var otherNationality = ""
    
    @Published var addressIsSameAsId = true
    @Published var currentAddress = ""
    
    @Published var hasHomeTelephone = false
    @Published var homeTelephoneNumber = ""
    @Published var mobilePhoneNumber = ""
    @Published var currentEmail = ""
    
    @Published var companyName = ""
    @Published var companyAddress = ""
    @Published var companyPhoneNumber = ""
    
    @Published var everBeenToJapan = false
    @Published var dayCountInJapanBefore = 0
    
    @Published var hasGuarantor = false
    @Published var guarantorGender: GenderEnum = .male
    @Published var guarantorName = ""
    @Published var guarantorAddress = ""
    @Published var guarantorBirthDate = Date()
    @Published var relationshipWithGuarantor = ""
    @Published var guarantorJob = ""
    @Published var guarantorJobPosition = ""
    @Published var guarantorNationality = ""
    
    @Published var hasInviter = false
    @Published var inviterSameAsGuarantor = true
    @Published var inviterGender: GenderEnum = .male
    @Published var inviterName = ""
    @Published var inviterAddress = ""
    @Published var inviterBirthDate = Date()
    @Published var relationshipWithInviter = ""
    @Published var inviterJob = ""
    @Published var inviterJobPosition = ""
    @Published var inviterNationality = ""
    
    @Published var convictedCrimeAnyCountry = false
    @Published var sentencedOneYearOrMore = false
    @Published var deportedFromJapan = false
    @Published var drugOffense = false
    @Published var engagedInProstitution = false
    @Published var commitTrafficking = false
    
    @Published var crimeDetails = ""
    
    func nextForm() {
        self.pageStep += 1
    }
    
    func resetFormPage() {
        self.pageStep = 1
    }
}
