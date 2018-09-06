//
//  Setting.swift
//  LBTA_YouTube
//
//  Created by Vlado Velkovski on 8/30/18.
//  Copyright © 2018 Vlado Velkovski. All rights reserved.
//

import UIKit

class Setting: NSObject {
    let imageName: String
    let labelName: SettingName
    
    init(imageName: String, labelName: SettingName) {
        self.imageName = imageName
        self.labelName = labelName
    }
}
