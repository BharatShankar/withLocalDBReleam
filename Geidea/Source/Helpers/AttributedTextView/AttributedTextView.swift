//
//  SwiftyLabel.swift
//
//  Created by Bharat Shankar on 25/11/2016.
//  Copyright © 2016 Bharat Shankar. All rights reserved.
//

import UIKit

/**
 Set this class as the 'Custom Class' when you add a UITextView in the interfacebuilder. 
 Use the attributer property for setting the attributed text.

 You can create your own textview class and use this class as it's base class. override the configureAttributedLabel function and set the self.attributer to your prefered styling. For instance self.attributer = self.text?.myHeader See the samples for how you could add your own custom property for interface builder and alsu use that.
 */
@IBDesignable open class AttributedTextView: UITextView, UITextViewDelegate {

    // required when using @IBDesignable
    override public init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
    }
    
    // required when using @IBDesignable
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // Make sure configureAttributedTextView is called right after activation from the storyboard.
    open override func awakeFromNib() {
        super.awakeFromNib()
        configureAttributedTextView()
    }
    
    // Make sure configureAttributedTextView is called inside interfacebuilder
    open override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        configureAttributedTextView()
    }
    
    // just an override for triggering configureAttributedTextView
    override open var text: String? {
        didSet {
            configureAttributedTextView()
        }
    }
    
    // For enabeling the size adjustment
    @IBInspectable open var forceIntrinsicContentSizeToBeContentSize: Bool = false {
        didSet { configureAttributedTextView() }
    }

    // Return the contentSize if its forced enabled
    override open var intrinsicContentSize: CGSize {
        return self.forceIntrinsicContentSizeToBeContentSize ? self.contentSize : super.intrinsicContentSize
    }

    // Subclass AttributedTextView and override this function if you want to use easy custum controls in interface builder
    open func configureAttributedTextView() {
    }
    
    // storage variable for the Attributer
    private var _attributer: Attributer?

    /**
     The attributer object that will set the attributedText
     */
    open var attributer: Attributer {
        get {
            if _attributer == nil {
                _attributer = Attributer("")
            }
            return _attributer!
        }
        set { 
            _attributer = newValue
            self.attributedText = _attributer?.attributedText

            super.delegate = self
            self.delaysContentTouches = false
            self.isUserInteractionEnabled = true
            self.isSelectable = true
            self.isEditable = false
            if let color = _attributer?.linkColor {
                self.linkTextAttributes = convertToOptionalNSAttributedStringKeyDictionary([NSAttributedString.Key.foregroundColor.rawValue : (color as Any)])
            }
        }
    }

    /**
     If you manually set the delegate on the AttributedTextView, then it will set this property instead of the actual delegate. The actual delegate will be set to this class itself for handling the interactions on the links. events will be forwarded to the _delegate.
     */
    public var _delegate: UITextViewDelegate?
    /**
     Delegate that can be set for forwarding events from the UITextView
     */
    override open var delegate: UITextViewDelegate? {
        get {
            return super.delegate
        }
        set {
            _delegate = newValue
        }
    }
    
    
    open override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        
        if newWindow == nil { return }
        
        // MARK: Customised
        // Adding guesture to detect if tap on link
        if _attributer?.urlCallbackByGuesture != nil {
            let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleLinkTap(_:)))
            self.addGestureRecognizer(tapRecognizer)
        }
    }
    
    /// END
    
    
    // MARK: - UITextViewDelegate functions - forwarding all to _delegate

    /**
     UITextViewDelegate function for forwarding the textViewShoudlBeginEditing
     
     -property textView: The UITextView where the delegate is called on
     */
    public func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return _delegate?.textViewShouldBeginEditing?(textView) ?? false
    }
    
    /**
     UITextViewDelegate function for forwarding the textViewShouldEndEditing
     
     -property textView: The UITextView where the delegate is called on
     */
    public func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        return _delegate?.textViewShouldEndEditing?(textView) ?? false
    }
    
    /**
     UITextViewDelegate function for forwarding the textViewDidBeginEditing
     
     -property textView: The UITextView where the delegate is called on
     */
    public func textViewDidBeginEditing(_ textView: UITextView) {
        _delegate?.textViewDidBeginEditing?(textView)
    }
    
    /**
     UITextViewDelegate function for forwarding the textViewDidEndEditing
     
     -property textView: The UITextView where the delegate is called on
     */
    public func textViewDidEndEditing(_ textView: UITextView) {
        _delegate?.textViewDidEndEditing?(textView)
    }
    
    
    /**
     UITextViewDelegate function for forwarding the shouldChangeTextIn range
     
     -property textView: The UITextView where the delegate is called on
     -property shouldChangeTextIn: the range
     -property replacementText: the replacement text
     */
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return _delegate?.textView?(textView, shouldChangeTextIn: range, replacementText: text) ?? false
    }
    
    /**
     UITextViewDelegate function for forwarding the textViewDidChange
     
     -property textView: The UITextView where the delegate is called on
     */
    public func textViewDidChange(_ textView: UITextView) {
        _delegate?.textViewDidChange?(textView)
    }
    
    /**
     UITextViewDelegate function for forwarding the textViewDidChangeSelection
     
     -property textView: The UITextView where the delegate is called on
     */
    public func textViewDidChangeSelection(_ textView: UITextView) {
        _delegate?.textViewDidChangeSelection?(textView)
    }
    
    /**
     UITextViewDelegate function for forwarding the shouldInteractWith URL
     
     -property textView: The UITextView where the delegate is called on
     -property shouldInteractWith: The URL to interact with
     -property characterRagne: the NSRange for the selection
     -property interaction: The UITextItemInteraction
     */
    @available(iOS 10.0, *)
    public func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
//        _attributer?.interactWithURL(URL: URL)
        return _delegate?.textView?(textView, shouldInteractWith: URL, in: characterRange, interaction: interaction) ?? false
    }
    
    /**
     UITextViewDelegate function for forwarding the shouldInteractWith textAttachment
     
     -property textView: The UITextView where the delegate is called on
     -property shouldInteractWith: the NSTextAttachement
     -property characterRange: the NSRange for the selection
     -property interaction: The UITextItemInteraction
     */
    @available(iOS 10.0, *)
    public func textView(_ textView: UITextView, shouldInteractWith textAttachment: NSTextAttachment, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        return _delegate?.textView?(textView, shouldInteractWith: textAttachment, in: characterRange, interaction: interaction) ?? false
    }
    
    /**
     UITextViewDelegate function for forwarding the shouldInteractWith URL
     
     -property textView: The UITextView where the delegate is called on
     -property shouldInteractWith: the NSTextAttachement
     -property characterRange: the NSRange for the selection
     */
    @available(iOS, introduced: 7.0, deprecated: 10.0, message: "Use textView:shouldInteractWithURL:inRange:forInteractionType: instead")
    public func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {
//        _attributer?.interactWithURL(URL: URL)
        return _delegate?.textView!(textView, shouldInteractWith: URL, in: characterRange) ?? false
    }
    
    /**
     UITextViewDelegate function for forwarding the shouldInteractWith textAttachment
     
     -property textView: The UITextView where the delegate is called on
     -property shouldInteractWith: the NSTextAttachement
     -property characterRange: the NSRange for the selection
     */
    @available(iOS, introduced: 7.0, deprecated: 10.0, message: "Use textView:shouldInteractWithURL:inRange:forInteractionType: instead")
    public func textView(_ textView: UITextView, shouldInteractWith textAttachment: NSTextAttachment, in characterRange: NSRange) -> Bool {
        return _delegate?.textView?(textView, shouldInteractWith: textAttachment, in: characterRange) ?? false
    }
}


// MARK: Customised
// Helps to detect if tapped on link, if tapped then calling handler

extension AttributedTextView {
    
    @objc func handleLinkTap(_ recognizer: UITapGestureRecognizer) {
        let tapLocation = recognizer.location(in: self)
        guard
            let textPosition = self.closestPosition(to: tapLocation),
            let url = self.textStyling(at: textPosition, in: .forward)?[NSAttributedString.Key.link],
            let urlString = (url as? String) ?? (url as? URL)?.absoluteString,
            let actualString = urlString.removingPercentEncoding
            else { return }
        
        _attributer?.urlCallbackByGuesture?(actualString)
    }
}


// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToOptionalNSAttributedStringKeyDictionary(_ input: [String: Any]?) -> [NSAttributedString.Key: Any]? {
	guard let input = input else { return nil }
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.Key(rawValue: key), value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromOptionalNSAttributedStringKeyDictionary(_ input: [NSAttributedString.Key: Any]?) -> [String: Any]? {
	guard let input = input else { return nil }
	return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}
