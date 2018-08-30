//
//  SettingsLauncher.swift
//  LBTA_YouTube
//
//  Created by Vlado Velkovski on 8/30/18.
//  Copyright © 2018 Vlado Velkovski. All rights reserved.
//

import UIKit

class SettingsLauncher: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let blackBackground = UIView()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        return cv
    }()
    
    let cellID = "cellId"
    
    @objc func showSettings() {
        print("more")
        
        if let window = UIApplication.shared.keyWindow {
            
            blackBackground.frame = window.frame
            blackBackground.backgroundColor = UIColor(white: 0, alpha: 0.5)
            
            blackBackground.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
            
            blackBackground.alpha = 0
            
            collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: window.frame.height)
            
            window.addSubview(blackBackground)
            window.addSubview(collectionView)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    self.blackBackground.alpha = 1
                    self.collectionView.frame = CGRect(x: 0, y: window.frame.height - 200, width: self.collectionView.frame.width, height: self.collectionView.frame.height)

            }, completion: nil)
        }
        
    }
    
    @objc func handleTap() {
        UIView.animate(withDuration: 0.5) {
        }
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                self.blackBackground.alpha = 0
                    self.collectionView.frame = CGRect(x: 0, y: self.collectionView.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
        }, completion: nil)

    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return (CGSize(width: collectionView.frame.width, height: 50))
    }
    
    override init() {
        super.init()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(SettingCell.self, forCellWithReuseIdentifier: cellID)
    }
}