//
//  File.swift
//  
//
//  Created by atakishiyev on 11/5/23.
//

import Foundation
import UIKit
import Common

public protocol LocalStorage {
    func fetchImage(imageUrl urlStr: String) async throws -> UIImage
    func saveImageToDisk(imageUrl urlStr: String, image: UIImage) async throws
    func resetCache()
}
