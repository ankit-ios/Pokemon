//
//  ImageCacheManager.swift
//  Pokedex
//
//  Created by Ankit Sharma on 26/10/23.
//

import Foundation
import SwiftUI

class ImageCacheManager {
    static let shared = ImageCacheManager()
    
    private let cacheDirectory: URL
    
    private init() {
        // Create a cache directory in the app's document directory
        let cacheURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        cacheDirectory = cacheURL.appendingPathComponent("ImageCache")
        
        do {
            try FileManager.default.createDirectory(at: cacheDirectory, withIntermediateDirectories: true, attributes: nil)
        } catch {
            // Handle error creating the cache directory
            print("Error creating cache directory: \(error)")
        }
    }
    
    // Save an image to the cache directory with a given URL name
    func saveImage(image: UIImage, urlName: String) {
        let fileURL = cacheDirectory.appendingPathComponent(urlName)
        if let imageData = image.pngData() {
            do {
                try imageData.write(to: fileURL)
            } catch {
                // Handle error while saving the image
                print("Error saving image: \(error)")
            }
        }
    }
    
    // Load an image from the cache by URL name
    func loadImage(urlName: String) -> Image? {
        let fileURL = cacheDirectory.appendingPathComponent(urlName)
        if let data = try? Data(contentsOf: fileURL),
           let uiImage = UIImage(data: data) {
            return Image(uiImage: uiImage)
        }
        return nil
    }
}
