//
//  CommonProtocol.swift
//  Geidea
//
//  Created by Bharat Shankar on 15/08/20.
//  Copyright © 2020 geidea. All rights reserved.
//

import Foundation

//*****************************************************************
// MARK: ProgramaticallyCreatable
//*****************************************************************

/// Appicable to all views or controllers which are programatically created
public protocol ProgramaticallyCreatable {
    
    /// Will help to add views
    func addViews()
    
    /// Will help to set constraints programatically, once view is added
    func setupConstraints()
}
