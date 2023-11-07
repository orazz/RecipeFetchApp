//
//  File.swift
//  
//
//  Created by atakishiyev on 11/5/23.
//

import Foundation

extension String {
    func extractImageNameFromURL() -> String? {
        if let url = URL(string: self) {
            let lastPathComponent = url.lastPathComponent
            return lastPathComponent.components(separatedBy: ".").first
        }
        return nil
    }
}
