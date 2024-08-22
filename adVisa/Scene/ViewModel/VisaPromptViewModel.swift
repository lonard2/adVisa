//
//  VisaPromptViewModel.swift
//  adVisa
//
//  Created by Dixon Willow on 21/08/24.
//

import Foundation

class VisaPromptViewModel: ObservableObject {
    
    @Published var startDate: Date = Date()
    @Published var endDate: Date = Date()
    @Published var passportType: String = "Regular Passport"
    @Published var travelPurpose: String = "Holiday"
    
    @Published var visitedPlaces: Bool = false
    @Published var isStudent: Bool = false
    
    private var totalDays = 0
    
    @Published var nextQuestion: Bool = false
    
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
}
