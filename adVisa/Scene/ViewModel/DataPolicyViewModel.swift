//
//  DataPolicyViewModel.swift
//  adVisa
//
//  Created by hendra on 16/08/24.
//

import Foundation

class DataPolicyViewModel: ObservableObject {
    @Published var isAgreeToTerms: Bool = false
    @Published var isAgreeToPrivacy: Bool = false
}
