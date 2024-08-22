//
//  DataPolicyViewModel.swift
//  adVisa
//
//  Created by hendra on 16/08/24.
//

import Foundation

class DataPolicyViewModel: ObservableObject {
    @Published var isAgreeToTerms: Bool {
        didSet {
            UserDefaults.standard.set(isAgreeToTerms, forKey: "isAgreeToTerms")
        }
    }
    
    @Published var isAgreeToPrivacy: Bool {
        didSet {
            UserDefaults.standard.set(isAgreeToPrivacy, forKey: "isAgreeToPrivacy")
        }
    }
    
    @Published var showSheet: Bool = true
    
    init() {
        self.isAgreeToTerms = UserDefaults.standard.bool(forKey: "isAgreeToTerms")
        self.isAgreeToPrivacy = UserDefaults.standard.bool(forKey: "isAgreeToPrivacy")
        self.showSheet = !isAgreeToTerms || !isAgreeToPrivacy
    }
}
