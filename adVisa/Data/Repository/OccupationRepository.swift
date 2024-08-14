//
//  OccupationRepository.swift
//  adVisa
//
//  Created by Dixon Willow on 14/08/24.
//

import Foundation
import Combine
import SwiftData

internal class OccupationRepository: DataRepositoryProtocol {
    
    typealias T = OccupationData
    
    private let container = SwiftDataContextManager.shared.occupationContainer
    
    func fetchById(id: String) -> AnyPublisher<OccupationData?, DataError> {
        return Future<OccupationData?, DataError> { promise in
            Task { @MainActor in
                let fetchDescriptor = FetchDescriptor<OccupationData>(
                    predicate: #Predicate<OccupationData> {
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
    
    func save(param: OccupationData) -> AnyPublisher<Bool, DataError> {
        return Future<Bool, DataError> { promise in
            Task { @MainActor in
                do {
                    let entity = OccupationData(
                        occupationData: param.occupationData,
                        positionData: param.positionData,
                        employerName: param.employerName
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
    
    func update(param: OccupationData) -> AnyPublisher<EmptyResponse, DataError> {
        return Future<EmptyResponse, DataError> { promise in
            Task { @MainActor in
                let id = param.id
                let fetchDescriptor = FetchDescriptor<OccupationData>(
                    predicate: #Predicate<OccupationData> {
                        $0.id == id
                    }
                )
                
                let result = Result {
                    do {
                        if let entity = try self.container?.mainContext.fetch(fetchDescriptor).first {
                            entity.occupationData = param.occupationData
                            entity.positionData = param.positionData
                            entity.employerName = param.employerName
                            
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
                    let fetchDescriptor = FetchDescriptor<OccupationData>(
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
