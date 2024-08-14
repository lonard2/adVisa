//
//  PassortRepository.swift
//  adVisa
//
//  Created by hendra on 14/08/24.
//

import Foundation
import Combine
import SwiftData

internal class PassortRepository: DataRepositoryProtocol {
    
    typealias T = PassportData
    
    private let container = SwiftDataContextManager.shared.passportContainer
    
    func fetchById(id: String) -> AnyPublisher<PassportData?, DataError> {
        return Future<PassportData?, DataError> { promise in
            Task { @MainActor in
                let fetchDescriptor = FetchDescriptor<PassportData>(
                    predicate: #Predicate<PassportData> {
                        $0.id == id
                    }
                )
                let result = Result {
                    do {
                        return try self.container?.mainContext.fetch(fetchDescriptor).first
                    }
                }
                
                switch result {
                case .success(let response):
                    promise(.success(response))
                case .failure(let error):
                    promise(.failure(.genericError(error: error)))
                }
            }
        
        }
        .eraseToAnyPublisher()
    }
    
    func save(param: PassportData) -> AnyPublisher<Bool, DataError> {
        return Future<Bool, DataError> { promise in
            Task { @MainActor in
                do {
                    let entity = PassportData(
                        surname: param.surname,
                        givenName: param.givenName,
                        dateOfBirth: param.dateOfBirth,
                        city: param.city,
                        state: param.state,
                        country: param.country,
                        gender: param.gender,
                        maritalStatus: param.maritalStatus, 
                        nationality: param.nationality,
                        passportType: param.passportType,
                        passportID: param.passportID,
                        placeOfIssue: param.placeOfIssue,
                        dateOfIssue: param.dateOfIssue,
                        issuingAuthority: param.issuingAuthority,
                        dateOfExpiry: param.dateOfExpiry
                    )
                    
                    self.container?.mainContext.insert(entity)
                    
                    try self.container?.mainContext.save()
                    promise(.success(true))
                } catch {
                    promise(.failure(.noData))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func update(param: PassportData) -> AnyPublisher<EmptyResponse, DataError> {
        return Future<EmptyResponse, DataError> { promise in
            Task { @MainActor in
                let id = param.id
                let fetchDescriptor = FetchDescriptor<PassportData>(
                    predicate: #Predicate<PassportData> {
                        $0.id == id
                    }
                )
                
                let result = Result {
                    do {
                        if let entity = try self.container?.mainContext.fetch(fetchDescriptor).first {
                            entity.city = param.city
                            entity.state = param.state
                            entity.country = param.country
                            entity.dateOfBirth = param.dateOfBirth
                            entity.dateOfExpiry = param.dateOfExpiry
                            entity.dateOfIssue = param.dateOfIssue
                            entity.gender = param.gender
                            entity.givenName = param.givenName
                            entity.surname = param.surname
                            entity.issuingAuthority = param.issuingAuthority
                            entity.maritalStatus = param.maritalStatus
                            entity.nationality = param.nationality
                            entity.passportID = param.passportID
                            entity.passportType = param.passportType
                            entity.placeOfIssue = param.placeOfIssue
                            
                            try self.container?.mainContext.save()
                            return EmptyResponse()
                        }
                        else {
                            throw DataError.noData
                        }
                    } catch {
                        throw error
                    }
                }
                
                switch result {
                case .success(let response):
                    promise(.success(response))
                case .failure(let error):
                    promise(.failure(.genericError(error: error)))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func delete(id: String) -> AnyPublisher<EmptyResponse, DataError> {
        return Future<EmptyResponse, DataError> { promise in
            Task { @MainActor in
                do {
                    let fetchDescriptor = FetchDescriptor<PassportData>(
                        predicate: #Predicate {
                            $0.id == id
                        }
                    )
                    
                    let result = Result {
                        do {
                            if let entity = try self.container?.mainContext.fetch(fetchDescriptor).first {
                                self.container?.mainContext.delete(entity)
                                try self.container?.mainContext.save()
                                return EmptyResponse()
                            } else {
                                throw DataError.noData
                            }
                        } catch {
                            throw error
                        }
                    }
                    switch result {
                    case .success(let response):
                        promise(.success(response))
                    case.failure(let error):
                        promise(.failure(.genericError(error: error)))
                    }
                }
                
            }
        }
        .eraseToAnyPublisher()
    }
}
