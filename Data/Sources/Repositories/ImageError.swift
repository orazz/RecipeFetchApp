//
//  File.swift
//  
//
//  Created by atakishiyev on 11/5/23.
//

import Foundation

enum ImageError: Error, LocalizedError {
    
    case invalidImageData
    
    var errorDescription: String? {
        return "Invalid image data"
    }
}
