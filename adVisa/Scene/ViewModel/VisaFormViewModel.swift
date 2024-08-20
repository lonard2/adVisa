//
//  VisaFormViewModel.swift
//  adVisa
//
//  Created by Dixon Willow on 20/08/24.
//

import Foundation

class VisaFormViewModel: ObservableObject {
    @Published var pageStep = 5
    
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
    
    func nextForm() {
        pageStep += 1
    }
}
