//
//  PdfPreviewVisaViewModel.swift
//  adVisa
//
//  Created by hendra on 22/08/24.
//

import Combine
import SwiftUI

class PdfPreviewVisaViewModel: ObservableObject {
    @Published var passportData: PassportData?
    @Published var identityCardData: IdentityCardData?
    @Published var guarantorData: GuarantorData?
    @Published var inviterData: InviterData?
    @Published var crimeRemarkData: CrimeRemarkData?
    @Published var travelHistoryData: TravelHistoryData?
    @Published var miscData: MiscData?
    @Published var domicileData: DomicileData?
    @Published var employerData: EmployerData?
    @Published var accomodationData: AccomodationData?
    
    private var cancellables = Set<AnyCancellable>()
    
    private let passportRepository: PassportRepository
    private let identityRepository: IdentityCardRepository
    private let guarantorRepository: GuarantorRepository
    private let inviterRepository: InviterRepository
    private let crimeRemarkRepository: CrimeRemarkRepository
    private let travelRepository: TravelHistoryRepository
    private let miscRepository: MiscRepository
    private let domicileRepository: DomicileRepository
    private let employerRepository: EmployerRepository
    private let accomodationRepository: AccomodationRepository
    
    init(passportRepository: PassportRepository = PassportRepository(),
         identityRepository:  IdentityCardRepository = IdentityCardRepository(),
         guarantorRepository:  GuarantorRepository = GuarantorRepository(),
         inviterRepository: InviterRepository = InviterRepository(),
         crimeRemarkRepository: CrimeRemarkRepository = CrimeRemarkRepository(),
         travelRepository: TravelHistoryRepository = TravelHistoryRepository(),
         miscRepository: MiscRepository = MiscRepository(),
         domicileRepository: DomicileRepository = DomicileRepository(),
         employerRepository: EmployerRepository = EmployerRepository(),
         accomodationRepository: AccomodationRepository = AccomodationRepository()
    ) {
        self.passportRepository = passportRepository
        self.identityRepository = identityRepository
        self.guarantorRepository = guarantorRepository
        self.inviterRepository = inviterRepository
        self.crimeRemarkRepository = crimeRemarkRepository
        self.travelRepository = travelRepository
        self.miscRepository = miscRepository
        self.domicileRepository = domicileRepository
        self.employerRepository = employerRepository
        self.accomodationRepository = accomodationRepository
        
        fetchPassportData()
        fetchIdentityCardData()
        fetchGuarantorData()
        fetchInviterData()
        fetchCrimeRemarkData()
        fetchTravelHistoryData()
        fetchMiscData()
        fetchDomicileData()
        fetchEmployerData()
        fetchAccomodationData()
    }
    
    func fetchPassportData() {
        passportRepository.fetchFirst()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching passport data: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] data in
                self?.passportData = data
            })
            .store(in: &cancellables)
    }
    
    func fetchIdentityCardData() {
        identityRepository.fetchFirst()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching passport data: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] data in
                self?.identityCardData = data
            })
            .store(in: &cancellables)
    }
    
    func fetchGuarantorData() {
        guarantorRepository.fetchFirst()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching passport data: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] data in
                self?.guarantorData = data
            })
            .store(in: &cancellables)
    }
    
    func fetchInviterData() {
        inviterRepository.fetchFirst()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching passport data: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] data in
                self?.inviterData = data
            })
            .store(in: &cancellables)
    }
    
    func fetchCrimeRemarkData() {
        crimeRemarkRepository.fetchFirst()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching passport data: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] data in
                self?.crimeRemarkData = data
            })
            .store(in: &cancellables)
    }
    
    func fetchTravelHistoryData() {
        travelRepository.fetchFirst()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching passport data: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] data in
                self?.travelHistoryData = data
            })
            .store(in: &cancellables)
    }
    
    func fetchMiscData() {
        travelRepository.fetchFirst()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching passport data: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] data in
                self?.travelHistoryData = data
            })
            .store(in: &cancellables)
    }
    
    func fetchDomicileData() {
        domicileRepository.fetchFirst()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching passport data: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] data in
                self?.domicileData = data
            })
            .store(in: &cancellables)
    }
    
    func fetchEmployerData() {
        employerRepository.fetchFirst()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching passport data: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] data in
                self?.employerData = data
            })
            .store(in: &cancellables)
    }
    
    func fetchAccomodationData() {
        accomodationRepository.fetchFirst()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching passport data: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] data in
                self?.accomodationData = data
            })
            .store(in: &cancellables)
    }
}
