//
//  File.swift
//  
//
//  Created by atakishiyev on 11/16/23.
//

import UIKit

final public class ImageCacheImpl: ImageCache {

    private var imageCache = NSCache<NSString, UIImage>()

    public init() {}

    public func fetchImage(imageUrl urlStr: String) -> UIImage? {
        if let cachedImage = self.imageCache.object(forKey: NSString(string: urlStr)) {
            return cachedImage
        }
        return nil
    }
    
    public func saveImageToCache(imageUrl urlStr: String, image: UIImage) {
        self.imageCache.setObject(image, forKey: NSString(string: urlStr))
    }
}
