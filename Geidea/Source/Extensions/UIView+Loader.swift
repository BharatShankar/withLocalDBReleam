


import Foundation
import UIKit

extension UIView {
    
    private weak static var container : UIView? = nil
    private weak static var activityIndicator : UIActivityIndicatorView? = nil
    private weak static var lblLoaderText : UILabel? = nil
    
    public func showActivityLoader(bgColor : UIColor? = nil, activityIndicatorStyle : UIActivityIndicatorView.Style = .gray, activityIndicatorColor : UIColor? = nil) {
        
        let container : UIView = UIView()
        container.isUserInteractionEnabled = true
        container.backgroundColor = bgColor ?? self.backgroundColor
        container.layer.cornerRadius = self.layer.cornerRadius
        container.layer.masksToBounds = self.layer.masksToBounds
        
        self.addSubview(container)
        container.snp.remakeConstraints { $0.edges.equalTo(self.snpSafeArea.edges) }
        
        let activityIndicator : UIActivityIndicatorView = UIActivityIndicatorView()
        activityIndicator.style = activityIndicatorStyle
        if let color = activityIndicatorColor { activityIndicator.color = color }
        container.addSubview(activityIndicator)
        activityIndicator.snp.remakeConstraints({ $0.center.equalToSuperview() })
        activityIndicator.startAnimating()
        
        UIView.container = container
        UIView.activityIndicator = activityIndicator
    }
    
    public func showActivityLoaderWithText(_ text : String, bgColor : UIColor? = nil, activityIndicatorStyle : UIActivityIndicatorView.Style = .gray, activityIndicatorColor : UIColor? = nil, textColor : UIColor? = nil) {
        
        let container : UIView = {
            let this : UIView = UIView()
            this.isUserInteractionEnabled = true
            this.backgroundColor = bgColor ?? self.backgroundColor
            this.layer.cornerRadius = self.layer.cornerRadius
            this.layer.masksToBounds = self.layer.masksToBounds
            return this
        }()
        
        self.addSubview(container)
        container.snp.remakeConstraints { $0.edges.equalTo(self.snpSafeArea.edges) }
        
        let lbl : UILabel = {
            let this : UILabel = UILabel()
            this.textColor = textColor ?? activityIndicatorColor ?? UIColor.black
            this.font = UIFont.regularFont(withSize: 12)
            this.text = text
            return this
        }()
        
        container.addSubview(lbl)
        lbl.snp.remakeConstraints({
            $0.top.equalTo(container.snp.centerY).space(S_WidthPerc: 0.6)
            $0.centerX.equalToSuperview()
        })
        
        let activityIndicator : UIActivityIndicatorView = {
            let this : UIActivityIndicatorView = UIActivityIndicatorView()
            this.style = activityIndicatorStyle
            this.startAnimating()
            if let color = activityIndicatorColor { this.color = color }
            return this
        }()
        
        container.addSubview(activityIndicator)
        activityIndicator.snp.remakeConstraints {
            $0.bottom.equalTo(container.snp.centerY).space(S_WidthPerc: 0.6)
            $0.centerX.equalToSuperview()
        }
        
        UIView.lblLoaderText = lbl
        UIView.container = container
        UIView.activityIndicator = activityIndicator
    }
    
    public func updateLoaderText(_ text : String) {
        UIView.lblLoaderText?.text = text
    }
    
    public func hideActivityLoader() {
        UIView.activityIndicator?.removeFromSuperview()
        UIView.container?.removeFromSuperview()
        
        UIView.activityIndicator = nil
        UIView.container = nil
    }
}
