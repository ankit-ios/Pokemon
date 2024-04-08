//
//  NetworkError.swift
//  Pokedex
//
//  Created by Ankit Sharma on 31/10/23.
//

import Foundation

enum NetworkError: Error {
    case invalidRequest
    case badRequest
    case failed
    case noData
    case invalidResponse
    case unableToDecode(Error)
    
    var description: String {
        
        switch self {
        case .invalidRequest: return "Invalid Request"
        case .badRequest: return "Bad Request"
        case .failed: return "Network Request Failed"
        case .noData: return "Response returned with no data"
        case .invalidResponse: return "Invalid Response return"
        case let .unableToDecode(error): return "Response couldnot be decoded \(error)"
        }
    }
}
