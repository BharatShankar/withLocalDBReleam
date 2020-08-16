//
//  SafeAreaHandling.swift
//  Goodsomnia Lab
//
//  Created by User on 29/05/18.
//  Copyright © 2018 IzissTechnology. All rights reserved.
//

import Foundation
import UIKit
import SnapKit


//************************************************
// MARK: ConstraintMakerEditable
//************************************************

extension ConstraintMakerEditable {
    
    /// This will help to give space as per height percentage
    /// eg: If passed value 10 then that will be 10% of screen height
    /// - Parameter amount: height percentage
    @discardableResult
    public func space(S_HeightPerc amount : CGFloat) -> ConstraintMakerEditable {
        return self.space(UIScreen.heightInPer(amount))
    }
    
    /// This will help to give space as per width percentage
    /// eg: If passed value 10 then that will be 10% of screen width
    /// - Parameter amount: width percentage
    @discardableResult
    public func space(S_WidthPerc amount : CGFloat) -> ConstraintMakerEditable {
        return self.space(UIScreen.widthInPer(amount))
    }
    
    /// This will help to prevent issues with negative value
    /// Constraint attribute '.right,.trailing,.bottom' required negative values for padding, eg: if set -10 right then that will be 10px padding from right, so this function will help to convert 10px to -10px....
    /// - Parameter offset: padding amount
    @discardableResult
    public func space(_ offset: CGFloat) -> ConstraintMakerEditable {
        
        guard let attribute = self.constraint.layoutConstraints.first?.firstAttribute else { fatalError("Attribute is empty")}
        
        var offset = offset
        
        switch attribute {
        case .right,.trailing,.bottom:
            offset = 0 - offset
        default:
            break
        }
        
        self.constraint.update(offset: offset)
 
        return self
    }
}


//************************************************
// MARK: ConstraintMakerRelatable
//************************************************

extension ConstraintMakerRelatable {
    
    /// Helps to set constraint equal to height percentage
    /// - Parameters:
    ///   - perc: height percentage
    ///   - file: not required
    ///   - line: not required
    @discardableResult
    public func equalTo(S_HeightPerc perc: CGFloat, _ file: String = #file, _ line: UInt = #line) -> SnapKit.ConstraintMakerEditable {
        
        return self.equalTo(UIScreen.heightInPer(perc), file, line)
    }
    
    /// Helps to set constraint equal to width percentage
    /// - Parameters:
    ///   - perc: width percentage
    ///   - file: not required
    ///   - line: not required
    @discardableResult
    public func equalTo(S_WidthPerc perc: CGFloat, _ file: String = #file, _ line: UInt = #line) -> SnapKit.ConstraintMakerEditable {
        
        return self.equalTo(UIScreen.widthInPer(perc), file, line)
    }
}


//************************************************
// MARK: UIView
//************************************************

extension UIView {
    
    /// This willl return safe area snp if needed
    public var snpSafeArea : ConstraintAttributesDSL {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.snp
        } else {
            return self.snp
        }
    }
}


//************************************************
// MARK: UIScreen
//************************************************

extension UIScreen {
    
    /// Helps to return height in percentage
    /// - Parameter per: percentage amount
    public static func heightInPer(_ per : CGFloat) -> CGFloat {
        return UIScreen.height * (per/100)
    }
    
    /// Helps to return width in percentage
    /// - Parameter per: width amount
    public static func widthInPer(_ per : CGFloat) -> CGFloat {
        return UIScreen.width * (per/100)
    }
    
    public static var height : CGFloat {
        return UIScreen.main.bounds.height
    }
    
    public static var width : CGFloat {
        return UIScreen.main.bounds.width
    }
}
