//
//  Video.swift
//  LBTA_YouTube
//
//  Created by Vlado Velkovski on 8/21/18.
//  Copyright © 2018 Vlado Velkovski. All rights reserved.
//

import UIKit

class Video: Codable, CustomStringConvertible {
    
    
    
    var thumbnailImageName: String?
    var title: String?
    var numberOfViews: Int?
    var duration: Int?
    // var uploadDate: Date?
    
    var channel: Channel?
    
    enum CodingKeys : String, CodingKey {
        case thumbnailImageName = "thumbnail_image_name"
        case title = "title"
        case numberOfViews = "number_of_views"
        case duration = "duration"
        case channel = "channel"
    }
    
    class Channel: Codable {
        
        var channelName: String?
        var profileImageName: String?
        
        enum CodingKeys : String, CodingKey {
            case channelName = "name"
            case profileImageName = "profile_image_name"
        }
        
        
    }

    
    var description: String {
        return "thumbnailImageName: \(thumbnailImageName) \n title: \(title) \n numberOfViews: \(numberOfViews) \n duration: \(duration) \n channel: \(channel) \n channel.channelName: \(channel?.channelName) \n channel.ProfileImageName: \(channel?.profileImageName)"
    }

}

