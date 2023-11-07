//
//  ViewState.swift
//  RecipeFetchApp
//
//  Created by atakishiyev on 11/4/23.
//

import Foundation

enum ViewState: Hashable, Equatable {
    case loading
    case success
    case error(alert: AlertContent)
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .error: hasher.combine("error")
        case .success: hasher.combine("success")
        case .loading: hasher.combine("loading")
        }
    }
    
    static func == (lhs: ViewState, rhs: ViewState) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
