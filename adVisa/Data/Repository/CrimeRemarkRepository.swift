//
//  CrimeRemarkRepository.swift
//  adVisa
//
//  Created by Dixon Willow on 14/08/24.
//

import Foundation
import Combine
import SwiftData

internal class CrimeRemarkRepository: DataRepositoryProtocol {
    
    typealias T = CrimeRemarkData
    
    private let container = SwiftDataContextManager.shared.crimeRemarkContainer
    
    func fetchById(id: String) -> AnyPublisher<CrimeRemarkData?, DataError> {
        return Future<CrimeRemarkData?, DataError> { promise in
            Task { @MainActor in
                let fetchDescriptor = FetchDescriptor<CrimeRemarkData>(
                    predicate: #Predicate<CrimeRemarkData> {
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
    
    func save(param: CrimeRemarkData) -> AnyPublisher<Bool, DataError> {
        return Future<Bool, DataError> { promise in
            Task { @MainActor in
                do {
                    let entity = CrimeRemarkData(
                        haveCrimeConvicted: param.haveCrimeConvicted,
                        haveImprisonedOneYear: param.haveImprisonedOneYear,
                        haveDeported: param.haveDeported,
                        haveDrugOffence: param.haveDrugOffence,
                        haveIllictOffence: param.haveIllictOffence,
                        haveTraffickingOffence: param.haveTraffickingOffence,
                        relevantDetails: param.relevantDetails
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
    
    func update(param: CrimeRemarkData) -> AnyPublisher<EmptyResponse, DataError> {
        return Future<EmptyResponse, DataError> { promise in
            Task { @MainActor in
                let id = param.id
                let fetchDescriptor = FetchDescriptor<CrimeRemarkData>(
                    predicate: #Predicate<CrimeRemarkData> {
                        $0.id == id
                    }
                )
                
                let result = Result {
                    do {
                        if let entity = try self.container?.mainContext.fetch(fetchDescriptor).first {
                            entity.haveCrimeConvicted = param.haveCrimeConvicted
                            entity.haveImprisonedOneYear = param.haveImprisonedOneYear
                            entity.haveDeported = param.haveDeported
                            entity.haveDrugOffence = param.haveIllictOffence
                            entity.haveTraffickingOffence = param.haveTraffickingOffence
                            entity.relevantDetails = param.relevantDetails
                            
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
                    let fetchDescriptor = FetchDescriptor<CrimeRemarkData>(
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
