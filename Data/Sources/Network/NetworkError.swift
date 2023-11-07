//
//  File.swift
//  
//
//  Created by atakishiyev on 11/4/23.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case serverConnectionFailed
    case jsonParsingFailed
    case invalidURL
    
    var description: String {
        switch self {
        case .serverConnectionFailed:
            return "Server connection failed. Check your internet connection or try again later."
        case .jsonParsingFailed:
            return "JSON parsing failed. The response data couldn't be processed."
        case .invalidURL:
            return "Invalid URL. Please check the URL configuration."
        }
    }
}
