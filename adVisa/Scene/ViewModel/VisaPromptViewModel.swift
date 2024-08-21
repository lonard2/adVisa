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
    
    @Published var nextQuestion: Bool = false
    
    func nextForm() {
        self.nextQuestion = true
    }
}
