//
//  NSObject+Classname.swift
//  Geidea
//
//  Created by Bharat Shankar on 15/08/20.
//  Copyright © 2020 geidea. All rights reserved.
//

import Foundation

extension NSObject {
    
    var className : String {
        return self.description
    }
    
    static var className : String {
        return self.description()
    }
}
