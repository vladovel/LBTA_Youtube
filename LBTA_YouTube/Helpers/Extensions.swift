//
//  Extensions.swift
//  LBTA_YouTube
//
//  Created by Vlado Velkovski on 8/17/18.
//  Copyright © 2018 Vlado Velkovski. All rights reserved.
//

import UIKit

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

extension UIView {
    func addConstraintsWithFormat(format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: [], metrics: nil, views: viewsDictionary))
        
    }
}

let imageCache = NSCache<NSString, UIImage>()

class CustomImageView: UIImageView {
    
    var imageUrlString: String?
    
    func loadImageUsingUrl(string: String) {
        
        imageUrlString = string
        
        let imageUrl = string
        
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: string as NSString) {
            self.image = imageFromCache
            print("Using image from cache ...")
            return
        }
        
        if let url = URL(string: imageUrl) {
            URLSession.shared.dataTask(with: url) {
                (data, response, error) in
                
                if error != nil {
                    print("error")
                    return
                }
                
                DispatchQueue.main.async {
                    
                    let imageToCache = UIImage(data: data!)
                    
                    if self.imageUrlString == string {
                        self.image = imageToCache
                        print("Loading image ...")
                    }
                    
                    imageCache.setObject(imageToCache!, forKey: string as NSString)

                }
                }.resume()
        }
    }
}



