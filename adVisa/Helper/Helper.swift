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

}

extension GuarantorData {
    func getOccupation() -> String {
        return "\(self.guarantorOccupation) as \(self.guarantorPosition)"
    }
    
    func getNationalityAndImmigrationStatus() -> String {
        return "\(self.guarantorNationality), \(self.guarantorImmigrationStatus)"
    }
}

extension InviterData {
    func getOccupation() -> String {
        return "\(self.inviterOccupation) as \(self.inviterPosition)"
    }
    
    func getNationalityAndImmigrationStatus() -> String {
        return "\(self.inviterNationality), \(self.inviterImmigrationStatus)"
    }
}
