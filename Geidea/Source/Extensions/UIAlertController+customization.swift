//
//  UIAlertController.swift
//  Geidea
//
//  Created by Bharat Shankar on 15/08/20.
//  Copyright © 2020 geidea. All rights reserved.
//

import UIKit

extension UIAlertController {
    
    static func show(onVc vc : UIViewController? = UIApplication.shared.keyWindow?.rootViewController, withTitle title : String, andMessage message : String, alertButtons : [UIAlertAction] = [], preferredStyle: UIAlertController.Style = .alert) {
        
        DispatchQueue.main.async {
            
            let ac = UIAlertController.init(title: title, message: message, preferredStyle: preferredStyle)
            
            if alertButtons.isEmpty {
                ac.addAction(UIAlertAction.init(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            } else {
                alertButtons.forEach({ ac.addAction($0) })
            }
            
            vc?.present(ac, animated: true, completion: nil)
        }
    }
}
