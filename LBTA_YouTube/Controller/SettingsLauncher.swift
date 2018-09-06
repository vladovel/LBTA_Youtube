//
//  SettingsLauncher.swift
//  LBTA_YouTube
//
//  Created by Vlado Velkovski on 8/30/18.
//  Copyright © 2018 Vlado Velkovski. All rights reserved.
//

import UIKit

enum SettingName: String {
    case Cancel = "Cancel"
    case Settings = "Settings"
    case Privacy = "Term & Privacy Policy"
    case Feedback = "Send Feedback"
    case SwitchAccount = "Switch Account"
    case Help = "Help"
}

class SettingsLauncher: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let blackBackground = UIView()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        return cv
    }()
    
    let cellID = "cellId"
    
//    let settings: [Setting] = [
//        Setting(imageName: "settings", labelName: "Settings"),
//        Setting(imageName: "privacy", labelName: "Terms & Privacy Policy"),
//        Setting(imageName: "feedback", labelName: "Send Feedback"),
//        Setting(imageName: "help", labelName: "Help"),
//        Setting(imageName: "switch_account", labelName: "Switch Account"),
//        Setting(imageName: "cancel", labelName: "Cancel")
//    ]
    
    let settings: [Setting] = [
        Setting(imageName: "settings", labelName: .Settings),
        Setting(imageName: "privacy", labelName: .Privacy),
        Setting(imageName: "feedback", labelName: .Feedback),
        Setting(imageName: "switch_account", labelName: .SwitchAccount),
        Setting(imageName: "help", labelName: .Help),
        Setting(imageName: "cancel", labelName: .Cancel)
        ]
    
    var homeController: HomeController?
    
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
                    self.collectionView.frame = CGRect(x: 0, y: window.frame.height - 300, width: self.collectionView.frame.width, height: self.collectionView.frame.height)

            }, completion: nil)
        }
        
    }
    
    @objc func handleTap(setting: Setting) {
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackBackground.alpha = 0
            self.collectionView.frame = CGRect(x: 0, y: self.collectionView.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
        }, completion: {
            (completed: Bool) in
            if setting.labelName != .Cancel {
                self.homeController?.showControllerForSetting(setting: setting)
            }
        })

    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! SettingCell
        
        let setting = settings[indexPath.item]

        
        cell.setting = setting

        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return (CGSize(width: collectionView.frame.width, height: 50))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let setting = settings[indexPath.item]
//        let  settingAlert = SettingAlert()
//        handleTap()
//        settingAlert.showAlert(with: setting.labelName)
//    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let setting = self.settings[indexPath.item]

        handleTap(setting: setting)
        
    }
    
    override init() {
        super.init()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(SettingCell.self, forCellWithReuseIdentifier: cellID)
    }
}
