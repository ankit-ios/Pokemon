//
//  AppConstants.swift
//  Pokedex
//
//  Created by Ankit Sharma on 26/10/23.
//

import Foundation

typealias HTTPMethod = AppConstants.API.HTTPMethod
typealias APIResponse<T: Decodable, E: Error> = (Result<T, E>) -> Void

enum User: String {
    case `default` = "Guest"
}

struct AppConstants {
    
    struct API {
        static func baseURL(_ user: User = .default) -> String {
            switch user {
            case  .default: return "https://pokeapi.co/api/v2"
            }
        }
        
        enum HTTPMethod: String {
            case get = "GET"
            case post = "POST"
        }
    }
}
