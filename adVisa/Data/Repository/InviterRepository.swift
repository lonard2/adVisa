//
//  InviterRepository.swift
//  adVisa
//
//  Created by Dixon Willow on 14/08/24.
//

import Foundation
import Combine
import SwiftData

internal class InviterRepository: DataRepositoryProtocol {
    
    typealias T = InviterData
    
    private let container = SwiftDataContextManager.shared.inviterContainer
    
    func fetchById(id: String) -> AnyPublisher<InviterData?, DataError> {
        return Future<InviterData?, DataError> { promise in
            Task { @MainActor in
                let fetchDescriptor = FetchDescriptor<InviterData>(
                    predicate: #Predicate<InviterData> {
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
    
    func save(param: InviterData) -> AnyPublisher<Bool, DataError> {
        return Future<Bool, DataError> { promise in
            Task { @MainActor in
                do {
                    let entity = InviterData(
                        inviterName: param.inviterName,
                        inviterTelephoneNum: param.inviterTelephoneNum,
                        inviterAddress: param.inviterAddress,
                        inviterDoB: param.inviterDoB,
                        inviterGender: param.inviterGender,
                        inviterRelationship: param.inviterRelationship,
                        inviterOccupation: param.inviterOccupation,
                        inviterPosition: param.inviterPosition,
                        inviterNationality: param.inviterNationality,
                        inviterImmigrationStatus: param.inviterImmigrationStatus
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
    
    func update(param: InviterData) -> AnyPublisher<EmptyResponse, DataError> {
        return Future<EmptyResponse, DataError> { promise in
            Task { @MainActor in
                let id = param.id
                let fetchDescriptor = FetchDescriptor<InviterData>(
                    predicate: #Predicate<InviterData> {
                        $0.id == id
                    }
                )
                
                let result = Result {
                    do {
                        if let entity = try self.container?.mainContext.fetch(fetchDescriptor).first {
                            entity.inviterName = param.inviterName
                            entity.inviterTelephoneNum = param.inviterTelephoneNum
                            entity.inviterAddress = param.inviterAddress
                            entity.inviterDoB = param.inviterDoB
                            entity.inviterGender = param.inviterGender
                            entity.inviterRelationship = param.inviterRelationship
                            entity.inviterOccupation = param.inviterOccupation
                            entity.inviterPosition = param.inviterPosition
                            entity.inviterNationality = param.inviterNationality
                            entity.inviterImmigrationStatus = param.inviterImmigrationStatus
                            
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
                    let fetchDescriptor = FetchDescriptor<InviterData>(
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
