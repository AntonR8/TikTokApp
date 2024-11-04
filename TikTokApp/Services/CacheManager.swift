//
//  CacheManager.swift
//  TikTokApp
//
//  Created by Антон Разгуляев on 18.10.2024.
//

import SwiftUI

class CacheManager {
    static var shared = CacheManager()
    private init() {}
    
    var imageCache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage> ()
        cache.countLimit = 100
        cache.totalCostLimit = 1024 * 1024 * 100
        return cache
    }()
    
    func add (image: UIImage, name: String) {
        imageCache.setObject(image, forKey: name as NSString)
        print ("Added to cache!")
    }
    
    func remove (name: String) {
        imageCache.removeObject(forKey: name as NSString)
        print ("Removed from cache!")
    }
    
    func get(name: String) -> UIImage? {
        return imageCache.object(forKey: name as NSString)
    }
}
