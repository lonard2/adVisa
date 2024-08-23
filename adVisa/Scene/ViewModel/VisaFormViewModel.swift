//
//  VisaFormViewModel.swift
//  adVisa
//
//  Created by Dixon Willow on 20/08/24.
//

import Foundation
import Combine

class VisaFormViewModel: ObservableObject {
    private var cancellables: Set<AnyCancellable> = []
    
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
    
    private let domicileRepository: DomicileRepository = DomicileRepository()
    private let employerRepository: EmployerRepository = EmployerRepository()
    private let crimeRemarkRepository: CrimeRemarkRepository = CrimeRemarkRepository()
    
    func nextForm() {
        self.pageStep += 1
    }
    
    func resetFormPage() {
        self.pageStep = 1
    }
    
    func saveDomicileData() {
        print(mobilePhoneNumber)
        print(homeTelephoneNumber)
        print(currentEmail)
        domicileRepository.save(param: DomicileData(currentPhoneNum: mobilePhoneNumber, currentTelephoneNum: homeTelephoneNumber, currentEmail: currentEmail))
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Save domicile successful")
                case .failure(let error):
                    // Handle the error
                    DispatchQueue.main.async {
                        print("Error saving identity card: \(error.localizedDescription)")
                    }
                }
            }, receiveValue: { success in
                // Handle the success case if needed (though here it is not strictly necessary)
            })
            .store(in: &cancellables) // Store the cancellable in a Set<AnyCancellable>
    }
    
    func saveEmployerData() {
        print(companyName)
        print(companyAddress)
        print(companyPhoneNumber)
        employerRepository.save(param: EmployerData(id: UUID().uuidString, employerName: companyName, employerTelephoneNum: companyPhoneNumber, employerAddress: companyAddress))
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Save company successful")
                case .failure(let error):
                    // Handle the error
                    DispatchQueue.main.async {
                        print("Error saving identity card: \(error.localizedDescription)")
                    }
                }
            }, receiveValue: { success in
                // Handle the success case if needed (though here it is not strictly necessary)
            })
            .store(in: &cancellables) // Store the cancellable in a Set<AnyCancellable>
    }
    
    func saveCrimeRemarkData() {
        crimeRemarkRepository.save(param: CrimeRemarkData(haveCrimeConvicted: convictedCrimeAnyCountry, haveImprisonedOneYear: sentencedOneYearOrMore, haveDeported: deportedFromJapan, haveDrugOffence: drugOffense, haveIllictOffence: engagedInProstitution, haveTraffickingOffence: commitTrafficking, relevantDetails: crimeDetails))
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Save company successful")
                case .failure(let error):
                    // Handle the error
                    DispatchQueue.main.async {
                        print("Error saving identity card: \(error.localizedDescription)")
                    }
                }
            }, receiveValue: { success in
                // Handle the success case if needed (though here it is not strictly necessary)
            })
            .store(in: &cancellables) // Store the cancellable in a Set<AnyCancellable>
    }
}
