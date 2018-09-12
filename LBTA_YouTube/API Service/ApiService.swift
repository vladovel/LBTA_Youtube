//
//  ApiService.swift
//  LBTA_YouTube
//
//  Created by Vlado Velkovski on 9/7/18.
//  Copyright © 2018 Vlado Velkovski. All rights reserved.
//

import UIKit

class ApiService: NSObject {
    
    static let sharedInstance = ApiService()
    
    let baseUrl = "https://s3-us-west-2.amazonaws.com/youtubeassets"
    
    
    func fetchFeedForUrlString(url: String, completion: @escaping ([Video]) -> Void) {
        
        let url = URL(string: url)
        
        URLSession.shared.dataTask(with: url!) {
            (data, response, error) in
            if error != nil {
                print(error.debugDescription)
                return
            }
            
            let decoder = JSONDecoder()
            if let videos = try? decoder.decode(Array<Video>.self, from: data!) {
                DispatchQueue.main.async {
                    completion(videos)
                }
            }
        }.resume()
    }
    
    func fetchSubscriptionsFeed(completion: @escaping ([Video]) -> Void) {
        fetchFeedForUrlString(url: "\(baseUrl)/subscriptions.json", completion: completion)
    }
    
    func fetchTrendingFeed(completion: @escaping ([Video]) -> Void) {
        fetchFeedForUrlString(url: "\(baseUrl)/trending.json", completion: completion)
    }
    
    func fetchVideos(completion: @escaping ([Video]) -> Void) {
        fetchFeedForUrlString(url: "\(baseUrl)/home_num_likes.json", completion: completion)
    }
    
    
}
