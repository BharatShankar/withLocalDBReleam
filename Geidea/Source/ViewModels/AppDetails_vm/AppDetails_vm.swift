//
//  AppDetails_vm.swift
//  Geidea
//
//  Created by Bharat Shankar on 15/08/20.
//  Copyright © 2020 geidea. All rights reserved.
//

import UIKit

protocol AppDetails_vm_delegate {
    func didTappedOnArtistName(name: String, url: URL)
    func didTappedOnDownloadNow(name: String, url: URL)
}

class AppDetails_vm {
    
    private let app: ModelApp
    
    public var delegate: AppDetails_vm_delegate? = nil
    
    init(withApp app: ModelApp) {
        self.app = app
    }
    
    /// Keeping it in let as this will help to identify tap
    /// Check func 'getDetailsAttributer' for more info
    private let strDownloadNow: String = "Download now"
    
    private var artistNameAttributer: Attributer {
        return Attributer("By: ")
            .font(UIFont.boldFont(withSize: 20))
            .color(UIColor.black)
            .append(app.artistName)
            .font(UIFont.regularFont(withSize: 20))
            .makeClickableAsLink()
            .setLinkColor(UIColor.white)
            .underline
    }
    
    private var releaseDateAttributer: Attributer {
        return Attributer("Released on: ")
            .font(UIFont.boldFont(withSize: 20))
            .color(UIColor.black)
            .append(app.releaseDate)
            .font(UIFont.regularFont(withSize: 20))
            .color(UIColor.darkGray)
    }
    
    private var genreAttributer: Attributer {
        return Attributer("Genre: ")
            .font(UIFont.boldFont(withSize: 20))
            .color(UIColor.black)
            .append(app.commaSeparatedGenersName)
            .font(UIFont.regularFont(withSize: 20))
            .color(UIColor.darkGray)
    }
    
    private var downloadNowAttributer: Attributer {
        return Attributer("Download now")
            .font(UIFont.boldFont(withSize: 20))
            .makeClickableAsLink()
            .setLinkColor(UIColor.blue)
            .underline
    }
    
    private var copyrightAttributer: Attributer {
        return Attributer(app.copyright)
            .font(UIFont.regularFont(withSize: 15))
            .color(UIColor.gray)
    }
    
    /// This will bind all the attributes and also will manage common settings, i.e. Paragraph spacing, styling, link tap handler....
    public var appDetailsAttributer: Attributer {
        
        return artistNameAttributer
            .append("\n")
            .append(releaseDateAttributer)
            .append("\n")
            .append(genreAttributer)
            .append("\n")
            .append(downloadNowAttributer)
            .append("\n\n")
            .append(copyrightAttributer)
            .all
            .paragraphSpacing(10)
            .paragraphAlignCenter
            .paragraphApplyStyling
            .clickableTextHandler({ [weak self] (str) in
                guard let this = self else { return }
                
                if str == this.strDownloadNow {
                    if let url: URL = URL.init(string: this.app.url) {
                        this.delegate?.didTappedOnDownloadNow(name: str, url: url)
                    }
                } else if str == this.app.artistName {
                    if let url: URL = URL.init(string: this.app.artistUrl) {
                        this.delegate?.didTappedOnArtistName(name: str, url: url)
                    }
                }
            })
    }
    
    public var appImageURLString : String {
        return self.app.artworkUrl100
    }
    
    public var appName: String {
        return self.app.name
    }
}
