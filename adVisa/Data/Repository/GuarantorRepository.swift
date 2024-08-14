//
//  GuarantorRepository.swift
//  adVisa
//
//  Created by Dixon Willow on 14/08/24.
//

import Foundation
import Combine
import SwiftData

internal class GuarantorRepository: DataRepositoryProtocol {
    
    typealias T = GuarantorData
    
    private let container = SwiftDataContextManager.shared.guarantorContainer
    
    func fetchById(id: String) -> AnyPublisher<GuarantorData?, DataError> {
        return Future<GuarantorData?, DataError> { promise in
            Task { @MainActor in
                let fetchDescriptor = FetchDescriptor<GuarantorData>(
                    predicate: #Predicate<GuarantorData> {
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
    
    func save(param: GuarantorData) -> AnyPublisher<Bool, DataError> {
        return Future<Bool, DataError> { promise in
            Task { @MainActor in
                do {
                    let entity = GuarantorData(
                        guarantorName: param.guarantorName,
                        guarantorTelephoneNum: param.guarantorTelephoneNum,
                        guarantorAddress: param.guarantorAddress,
                        guarantorDoB: param.guarantorDoB,
                        guarantorGender: param.guarantorGender,
                        guarantorRelationship: param.guarantorRelationship,
                        guarantorOccupation: param.guarantorOccupation,
                        guarantorPosition: param.guarantorPosition,
                        guarantorNationality: param.guarantorNationality,
                        guarantorImmigrationStatus: param.guarantorImmigrationStatus
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
    
    func update(param: GuarantorData) -> AnyPublisher<EmptyResponse, DataError> {
        return Future<EmptyResponse, DataError> { promise in
            Task { @MainActor in
                let id = param.id
                let fetchDescriptor = FetchDescriptor<GuarantorData>(
                    predicate: #Predicate<GuarantorData> {
                        $0.id == id
                    }
                )
                
                let result = Result {
                    do {
                        if let entity = try self.container?.mainContext.fetch(fetchDescriptor).first {
                            entity.guarantorName = param.guarantorName
                            entity.guarantorTelephoneNum = param.guarantorTelephoneNum
                            entity.guarantorAddress = param.guarantorAddress
                            entity.guarantorDoB = param.guarantorDoB
                            entity.guarantorGender = param.guarantorGender
                            entity.guarantorRelationship = param.guarantorRelationship
                            entity.guarantorOccupation = param.guarantorOccupation
                            entity.guarantorPosition = param.guarantorPosition
                            entity.guarantorNationality = param.guarantorNationality
                            entity.guarantorImmigrationStatus = param.guarantorImmigrationStatus
                            
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
                    let fetchDescriptor = FetchDescriptor<GuarantorData>(
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
