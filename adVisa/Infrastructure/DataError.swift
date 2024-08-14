//
//  DataError.swift
//  adVisa
//
//  Created by hendra on 14/08/24.
//

import Foundation

enum DataError: Error {
    case invalidResponse
    case noData
    case invalidParameters
    case errorResponse(error: ResponseError)
    case genericError(error: Error)
    #warning("TODO ERROR HANDLING RESPONSE")
    // TODO: ERROR HANDLING RESPONSE
    var errorMessage: String {
        switch self {
        case .errorResponse(let error):
            return error.message ?? "We couldn't connect to our data. Please retry again and make sure internet connection is good."
        default:
            return "We couldn't connect to our data. Please retry again and make sure internet connection is good."
        }
    }
}
