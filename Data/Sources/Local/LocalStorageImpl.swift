//
//  File.swift
//
//
//  Created by atakishiyev on 11/5/23.
//

import Foundation
import UIKit

final public class LocalStorageImpl: LocalStorage {
    
    private let cacheDestFolder = "images"
    private let fileManager = FileManager.default
    
    public init() {}
    
    public func fetchImage(imageUrl urtStr: String) async throws -> UIImage {
        return try await withCheckedThrowingContinuation({ continuation in
            guard let docsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
                continuation.resume(throwing: LocalError.imageFetchFailed)
                return
            }
            
            guard let fileName = urtStr.extractImageNameFromURL() else {
                continuation.resume(throwing: LocalError.imageFetchFailed)
                return
            }
            
            var fileURL = docsDirectory.appendingPathComponent(cacheDestFolder)
            fileURL = fileURL.appendingPathComponent(fileName + ".jpg")
            
            guard fileManager.fileExists(atPath: fileURL.path) else {
                continuation.resume(throwing: LocalError.imageFetchFailed)
                return
            }
            
            guard let image = UIImage(contentsOfFile: fileURL.path) else {
                continuation.resume(throwing: LocalError.imageFetchFailed)
                return
            }
            
            continuation.resume(returning: image)
        })
    }
    
    public func saveImageToDisk(imageUrl urlStr: String, image: UIImage) async throws {
        return try await withCheckedThrowingContinuation({ continuation in
            guard let imageData = image.jpegData(compressionQuality: 1) else {
                continuation.resume(throwing: LocalError.imageSaveFailed)
                return
            }
            
            guard let docsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
                continuation.resume(throwing: LocalError.imageSaveFailed)
                return
            }
            
            guard let fileName = urlStr.extractImageNameFromURL() else {
                continuation.resume(throwing: LocalError.imageSaveFailed)
                return
            }
            
            createImageFolderIfNeeded()
            var fileURL = docsDirectory.appendingPathComponent(cacheDestFolder)
            fileURL = fileURL.appendingPathExtension("\(fileName).jpg")
            
            guard !fileManager.fileExists(atPath: fileURL.path) else {
                continuation.resume(throwing: LocalError.imageSaveFailedDueToExistingImage)
                return
            }
            
            do {
                try imageData.write(to: fileURL)
                continuation.resume()
            } catch {
                continuation.resume(throwing: LocalError.imageSaveFailed)
            }
        })
    }
    
    public func resetCache() {
        guard let docsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return
        }
        
        let fileUrl = docsDirectory.appendingPathComponent(cacheDestFolder)
        try? fileManager.removeItem(atPath: fileUrl.path)
    }
    
    func createImageFolderIfNeeded() {
        guard let docsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return
        }
        
        let imagesFolderURL = docsDirectory.appendingPathComponent(cacheDestFolder)
        guard !fileManager.fileExists(atPath: imagesFolderURL.path) else { return }
        do {
            try fileManager.createDirectory(at: imagesFolderURL, withIntermediateDirectories: true, attributes: nil)
        } catch {
            print("Error creating images folder: \(error)")
        }
    }
}
