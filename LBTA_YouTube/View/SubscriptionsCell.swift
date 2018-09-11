//
//  TrendingCell.swift
//  LBTA_YouTube
//
//  Created by Vlado Velkovski on 9/10/18.
//  Copyright © 2018 Vlado Velkovski. All rights reserved.
//

import UIKit

class SubscriptionsCell: FeedCell {
    
    //    var videos: [Video]?
    
    override func fetchVideos() {
        
        ApiService.sharedInstance.fetchSubscriptionsFeed(completion: { (videos) in
            self.videos = videos
            self.collectionView.reloadData()

        })
        
    }
    
}
