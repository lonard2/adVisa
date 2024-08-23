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
    @Published var guarantorPhoneNumber = ""
    @Published var guarantorAddress = ""
    @Published var guarantorBirthDate = Date()
    @Published var relationshipWithGuarantor = ""
    @Published var guarantorJob = ""
    @Published var guarantorJobPosition = ""
    @Published var guarantorNationality = ""
    @Published var guarantorImmigrationStatus = ""
    
    @Published var hasInviter = false
    @Published var inviterSameAsGuarantor = true
    @Published var inviterGender: GenderEnum = .male
    @Published var inviterName = ""
    @Published var inviterPhoneNumber = ""
    @Published var inviterAddress = ""
    @Published var inviterBirthDate = Date()
    @Published var relationshipWithInviter = ""
    @Published var inviterJob = ""
    @Published var inviterJobPosition = ""
    @Published var inviterNationality = ""
    @Published var inviterImmigrationStatus = ""
    
    @Published var convictedCrimeAnyCountry = false
    @Published var sentencedOneYearOrMore = false
    @Published var deportedFromJapan = false
    @Published var drugOffense = false
    @Published var engagedInProstitution = false
    @Published var commitTrafficking = false
    
    @Published var crimeDetails = ""
    
    private let domicileRepository: DomicileRepository = DomicileRepository()
    private let employerRepository: EmployerRepository = EmployerRepository()
    private let guarantorRepostory: GuarantorRepository = GuarantorRepository()
    private let inviterRepository: InviterRepository = InviterRepository()
    private let crimeRemarkRepository: CrimeRemarkRepository = CrimeRemarkRepository()
    private let miscRepository: MiscRepository = MiscRepository()
    
    func nextForm() {
        self.pageStep += 1
    }
    
    func resetFormPage() {
        self.pageStep = 1
    }
    
    func saveDomicileData() {
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
    
    func saveGuarantorData() {
        guarantorRepostory.save(param: GuarantorData(guarantorName: guarantorName, guarantorTelephoneNum: guarantorPhoneNumber, guarantorAddress: guarantorAddress, guarantorDoB: guarantorBirthDate, guarantorGender: guarantorGender, guarantorRelationship: relationshipWithGuarantor, guarantorOccupation: guarantorJob, guarantorPosition: guarantorJobPosition, guarantorNationality: guarantorNationality, guarantorImmigrationStatus: guarantorImmigrationStatus))
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Save guarantor successful")
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
    
    func saveInviterData() {
        
        if inviterSameAsGuarantor {
            inviterName = guarantorName
            inviterPhoneNumber = guarantorPhoneNumber
            inviterAddress = guarantorAddress
            inviterBirthDate = guarantorBirthDate
            inviterGender = guarantorGender
            relationshipWithInviter = relationshipWithGuarantor
            inviterJob = guarantorJob
            inviterJobPosition = guarantorJobPosition
            inviterNationality = guarantorNationality
            inviterImmigrationStatus = guarantorImmigrationStatus
        }
        
        inviterRepository.save(param: InviterData(inviterName: inviterName, inviterTelephoneNum: inviterPhoneNumber, inviterAddress: inviterAddress, inviterDoB: inviterBirthDate, inviterGender: inviterGender, inviterRelationship: relationshipWithInviter, inviterOccupation: inviterJob, inviterPosition: inviterJobPosition, inviterNationality: inviterNationality, inviterImmigrationStatus: inviterImmigrationStatus))
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Save inviter successful")
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
    
    func updateMiscData() {
        miscRepository.fetchFirst()
            .receive(on: DispatchQueue.main)
            .flatMap { [weak self] data -> AnyPublisher<EmptyResponse, DataError> in
                guard let self = self else {
                    return Fail(error: DataError.genericError(error: NSError(domain: "ViewModel", code: -1, userInfo: nil)))
                        .eraseToAnyPublisher()
                }
                let updatedData = data
                // Perform any updates to the fetched data here
                updatedData?.otherNames = otherName
                updatedData?.formerNationality = priorNationality == "" ? otherNationality : priorNationality
                
                return self.miscRepository.update(param: updatedData!)
            }
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error updating misc data: \(error)")
                case .finished:
                    print("Successfully updated misc data")
                }
            }, receiveValue: { _ in
                // Handle successful update if needed
            })
            .store(in: &cancellables)
    }
    
}
