//
//  EmployerRepository.swift
//  adVisa
//
//  Created by Dixon Willow on 14/08/24.
//

import Foundation
import Combine
import SwiftData

internal class EmployerRepository: DataRepositoryProtocol {
    
    typealias T = EmployerData
    
    private let container = SwiftDataContextManager.shared.employerContainer
    
    func fetchById(id: String) -> AnyPublisher<EmployerData?, DataError> {
        return Future<EmployerData?, DataError> { promise in
            Task { @MainActor in
                let fetchDescriptor = FetchDescriptor<EmployerData>(
                    predicate: #Predicate<EmployerData> {
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
    
    func save(param: EmployerData) -> AnyPublisher<Bool, DataError> {
        return Future<Bool, DataError> { promise in
            Task { @MainActor in
                do {
                    let entity = EmployerData(
                        employerName: param.employerName,
                        employerTelephoneNum: param.employerTelephoneNum,
                        employerAddress: param.employerAddress
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
    
    func update(param: EmployerData) -> AnyPublisher<EmptyResponse, DataError> {
        return Future<EmptyResponse, DataError> { promise in
            Task { @MainActor in
                let id = param.id
                let fetchDescriptor = FetchDescriptor<EmployerData>(
                    predicate: #Predicate<EmployerData> {
                        $0.id == id
                    }
                )
                
                let result = Result {
                    do {
                        if let entity = try self.container?.mainContext.fetch(fetchDescriptor).first {
                            entity.employerName = param.employerName
                            entity.employerTelephoneNum = param.employerTelephoneNum
                            entity.employerAddress = param.employerAddress
                            
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
                    let fetchDescriptor = FetchDescriptor<EmployerData>(
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
