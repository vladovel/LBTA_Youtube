//
//  SetttingsAlert.swift
//  LBTA_YouTube
//
//  Created by Vlado Velkovski on 8/30/18.
//  Copyright © 2018 Vlado Velkovski. All rights reserved.
//

import UIKit

class SettingAlert: UIViewController {
    
    let label = ""
    
    
    
    func showAlert(with label: String) {
        
        let alertController = UIAlertController(title: label, message: "Do something with: \(label)", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel) {
            _ in
            print(".....")
        }
        alertController.addAction(action)
        
        presentViewController(alert: alertController, animated: true, completion: nil)
        
    }
    
    private func presentViewController(alert: UIAlertController, animated flag: Bool, completion: (() -> Void)?) -> Void {
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: flag, completion: completion)
    }

    
    
}





