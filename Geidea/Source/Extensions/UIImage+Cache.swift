//
//  UIImage+Cache.swift
//  Geidea
//
//  Created by Bharat Shankar on 15/08/20.
//  Copyright © 2020 geidea. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func loadImageFrom(_ urlString : String, completionHandler : (() -> Void)? = nil) {
        
        if let url = URL.init(string: urlString) {
            self.kf.indicatorType = .activity
            (self.kf.indicator?.view as? UIActivityIndicatorView)?.color = .white
            self.kf.setImage(with: url, options: [.transition(ImageTransition.fade(0.5))]) { (result) in
                completionHandler?()
            }
        }
    }
}
