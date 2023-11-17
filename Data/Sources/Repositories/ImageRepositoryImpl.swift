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
    private var imageCache: ImageCache
    
    public init(api: Api, imageCache: ImageCache) {
        self.api = api
        self.imageCache = imageCache
    }
    
    public func fetchImageFromServer(imageUrl url: String) async throws -> UIImage {
        let data = try await api.fetchImageData(route: .imageUrl(imageUrl: url))
        guard let image = UIImage(data: data) else {
            throw ImageError.invalidImageData
        }
        return image
    }
    
    public func fetchImageFromLocal(imageUrl url: String) -> UIImage? {
        return self.imageCache.fetchImage(imageUrl: url)
    }
    
    public func saveImageToCache(imageUrl url: String, image: UIImage)  {
        self.imageCache.saveImageToCache(imageUrl: url, image: image)
    }
}
