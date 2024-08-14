//
//  BaseResponse.swift
//  adVisa
//
//  Created by hendra on 14/08/24.
//

import Foundation

struct BaseResponse<T: Codable>: Codable {
    public let payload: T?
    public let errors: ResponseError?
}

struct ResponseError: Codable {
    public let code: String?
    public let message: String?
}

extension Error {
    func toResponseError() -> DataError {
        if let responseError = self as? DataError {
            return responseError
        } else {
            return .genericError(error: self)
        }
    }
}
