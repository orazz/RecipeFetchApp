//
//  File.swift
//  
//
//  Created by atakishiyev on 11/5/23.
//

import Foundation
import UIKit
import Domain
import Network
import Common
import Local

public class ImageRepositoryImpl: ImageRepository {
    
    private var api: Api
    private var localStorage: LocalStorage
    
    public init(api: Api, localStorage: LocalStorage) {
        self.api = api
        self.localStorage = localStorage
    }
    
    public func fetchImageFromServer(imageUrl url: String) async throws -> UIImage {
        let data = try await api.fetchImageData(route: .imageUrl(imageUrl: url))
        guard let image = UIImage(data: data) else {
            throw ImageError.invalidImageData
        }
        return image
    }
    
    public func fetchImageFromLocal(imageUrl url: String) async throws -> UIImage {
        return try await self.localStorage.fetchImage(imageUrl: url)
    }
    
    public func saveImageToDisk(imageUrl url: String, image: UIImage) async throws {
        try await self.localStorage.saveImageToDisk(imageUrl: url, image: image)
    }
    
    public func resetCache() {
        localStorage.resetCache()
    }
}
