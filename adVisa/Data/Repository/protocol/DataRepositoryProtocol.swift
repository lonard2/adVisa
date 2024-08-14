//
//  DataProtocol.swift
//  adVisa
//
//  Created by hendra on 14/08/24.
//

import Foundation
import Combine

import Combine

internal protocol DataRepositoryProtocol {
    associatedtype T
    func fetchById(id: String) -> AnyPublisher<T?, DataError>
    func save(param: T) -> AnyPublisher<Bool, DataError>
    func update(param: T) -> AnyPublisher<EmptyResponse, DataError>
    func delete(id: String) -> AnyPublisher<EmptyResponse, DataError>
}
