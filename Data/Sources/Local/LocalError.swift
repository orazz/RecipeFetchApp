//
//  File.swift
//  
//
//  Created by atakishiyev on 11/5/23.
//

import Foundation

enum LocalError: Error, LocalizedError {
    
    case imageSaveFailed
    case imageSaveFailedDueToExistingImage
    case imageFetchFailed
    
    public var errorDescription: String? {
        switch self {
        case .imageSaveFailed: return "Failed to save the image to disk"
        case .imageSaveFailedDueToExistingImage: return "Failed to save the image to disk because the image already exists"
        case .imageFetchFailed: return "Failed to fetch the image"
        }
    }
}
