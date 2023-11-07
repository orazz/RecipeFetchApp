//
//  File.swift
//  
//
//  Created by atakishiyev on 11/4/23.
//

import Foundation

public enum DomainError: Error {
    
    case cannotFetchMealList
    case cannotFetchMealDetail
    case cannotLoadImage
    
    var errorDescription: String? {
        switch self {
        case .cannotLoadImage:
            return "Image load failed."
        case .cannotFetchMealDetail:
            return "Failed to fetch Meal detail"
        case .cannotFetchMealList:
            return "Failed to fetch Meal list."
        }
    }
}
