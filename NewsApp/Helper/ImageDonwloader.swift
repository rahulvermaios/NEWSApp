//
//  ImageDonwloader.swift
//  NewsApp
//
//  Created by rahulverma on 14/8/23.
//

import Foundation
import UIKit

typealias imageClosure = ((UIImage?) -> ())

class ImageDonwloader {
    
    static let shared = ImageDonwloader()
    
    private let cacheImage: NSCache<NSURL, UIImage> = {
        let cache = NSCache<NSURL, UIImage>()
        cache.totalCostLimit = 50_000_000
        return cache
    }()
    
    private let cacheAccessQueue = DispatchQueue(label: "com.newsapp.imagedownloader.cacheAccessQueue", attributes: .concurrent)
    
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        config.urlCache = URLCache.shared
        return URLSession(configuration: config)
    }()
    
    func downloadImage(with url: URL, completion: @escaping imageClosure) {
        
        cacheAccessQueue.async {
            if let cachedImage = self.cacheImage.object(forKey: url as NSURL) {
                DispatchQueue.main.async {
                    completion(cachedImage)
                }
            } else {
                let task = self.session.dataTask(with: url) { data, response, error in
                    guard let data = data, let image = UIImage(data: data) else {
                        DispatchQueue.main.async {
                            completion(nil)
                        }
                        return
                    }
                    
                    self.cacheAccessQueue.async(flags: .barrier) {
                        self.cacheImage.setObject(image, forKey: url as NSURL, cost: data.count)
                    }
                    
                    DispatchQueue.main.async {
                        completion(image)
                    }
                }
                
                task.resume()
            }
        }
    }
}
