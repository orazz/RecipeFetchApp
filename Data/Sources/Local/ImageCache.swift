//
//  File.swift
//  
//
//  Created by atakishiyev on 11/16/23.
//

import UIKit

public protocol ImageCache {
    func fetchImage(imageUrl urlStr: String) -> UIImage?
    func saveImageToCache(imageUrl urlStr: String, image: UIImage)
}
