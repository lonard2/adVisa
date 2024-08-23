//
//  VisaPromptViewModel.swift
//  adVisa
//
//  Created by Dixon Willow on 21/08/24.
//

import Foundation
import Combine

class VisaPromptViewModel: ObservableObject {
    
    private var cancellables: Set<AnyCancellable> = []
    
    @Published var startDate: Date = Date()
    @Published var endDate: Date = Date()
    @Published var passportType: String = "Regular Passport"
    @Published var travelPurpose: String = "Holiday"
    
    @Published var visitedPlaces: Bool = false
    @Published var isStudent: Bool = false
    
    private var totalDays = 0
    
    @Published var nextQuestion: Bool = false
    
    private let miscRepository: MiscRepository = MiscRepository()
    
    func nextForm() {
        self.nextQuestion = true
    }
    
    func resetFormPage() {
        self.nextQuestion = false
    }
    
    func countTotalDays() -> Int {
        let calendar = Calendar.current
        
        if calendar.isDate(self.startDate, equalTo: self.endDate, toGranularity: .day) {
            totalDays = 1
        }

        if let days = calendar.dateComponents([.day], from: self.startDate, to: self.endDate).day {
            totalDays = days + 2
        }
        
        return totalDays
    }
    
    func saveTraveData() {
        miscRepository.save(param: MiscData(visitPurpose: travelPurpose, durationStay: String(totalDays), otherNames: "", formerNationality: "", dateOfArrival: startDate, portOfEntry: "", shipAirlineName: ""))
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Save MISCCC data successful")
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
