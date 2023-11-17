//
//  File.swift
//  
//
//  Created by atakishiyev on 11/16/23.
//

import UIKit

final public class ImageCacheImpl: ImageCache {

    private var cache = [String: UIImage]()

    public init() {}

    public func fetchImage(imageUrl urlStr: String) -> UIImage? {
        if let cachedImage = self.cache[urlStr] {
            return cachedImage
        }
        return nil
    }
    
    public func saveImageToCache(imageUrl urlStr: String, image: UIImage) {
        self.cache[urlStr] = image
    }
}
