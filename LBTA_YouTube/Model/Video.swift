//
//  Video.swift
//  LBTA_YouTube
//
//  Created by Vlado Velkovski on 8/21/18.
//  Copyright © 2018 Vlado Velkovski. All rights reserved.
//

import UIKit

class Video: NSObject {
    
    var thumbnailImageName: String?
    var title: String?
    var numberOfViews: NSNumber?
    var uploadDate: NSDate?
    
    var channel: Channel?
    
}

class Channel: NSObject {
    
    var channelName: String?
    var profileImageName: String?
    
}
