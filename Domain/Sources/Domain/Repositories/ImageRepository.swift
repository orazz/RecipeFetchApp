//
//  File.swift
//  
//
//  Created by atakishiyev on 11/5/23.
//

import Foundation
import UIKit

public protocol ImageRepository {
    func fetchImageFromServer(imageUrl url: String) async throws -> UIImage
    func fetchImageFromLocal(imageUrl url: String) async throws -> UIImage
    func saveImageToDisk(imageUrl url: String, image: UIImage) async throws
    func resetCache()
}
