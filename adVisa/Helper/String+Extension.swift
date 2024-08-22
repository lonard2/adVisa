//
//  String+Extension.swift
//  adVisa
//
//  Created by hendra on 21/08/24.
//

import Foundation

extension String {
    func convertToDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy" // Match the format of the date string
        
        return dateFormatter.date(from: self)
    }
    
    func genderFromText() -> GenderEnum? {
        let normalizedText = self.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !normalizedText.isEmpty else { return nil }
        
        switch normalizedText.prefix(1) { // Use only the first character
        case "P", "F":
            return .female
        case "L", "M":
            return .male
        default:
            return nil
        }
    }
}
