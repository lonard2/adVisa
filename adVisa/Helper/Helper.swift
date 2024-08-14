//
//  Helper.swift
//  adVisa
//
//  Created by Lonard Steven on 13/08/24.
//

import Foundation

extension PassportData {
    func getPlaceOfBirth() -> String {
        return "\(self.city), \(self.state), \(self.country)"
    }
}

extension TravelHistoryData {
    func getDuration() -> String {
        return "\(self.travelDuration) days"
    }
}

extension GuarantorData {
    func getNationalityAndImmigrationStatus() -> String {
        return "\(self.nationality), \(self.immigrationStatus)"
    }
}
