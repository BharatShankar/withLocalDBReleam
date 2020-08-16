//
//  AppList_cell.swift
//  Geidea
//
//  Created by Bharat Shankar on 15/08/20.
//  Copyright © 2020 geidea. All rights reserved.
//

import UIKit

class AppList_cell: UICollectionViewCell {
    
    //************************************************
    // MARK: Programatic view properties
    //************************************************
    
    lazy private var baseView : UIView = {
        let this = UIView()
        return this
    }()
    
    lazy private var imgvArtwork : UIImageView = {
        let this : UIImageView = UIImageView()
        this.contentMode = .scaleAspectFill
        this.clipsToBounds = true
        this.backgroundColor = UIColor.white
        return this
    }()
    
    lazy private var lblName : UILabel = {
        let this = UILabel()
        this.font = UIFont.boldFont(withSize: 14)
        this.textColor = UIColor.black
        return this
    }()
    
    lazy private var lblGenreDetails : UILabel = {
        let this = UILabel()
        this.font = UIFont.regularFont(withSize: 13)
        this.textColor = UIColor.darkGray
        return this
    }()
    
    lazy private var lblReleaseDate : UILabel = {
        let this = UILabel()
        this.font = UIFont.regularFont(withSize: 12)
        this.textColor = UIColor.lightGray
        return this
    }()
    
    
    //************************************************
    // MARK: Properties
    //************************************************
    
    /// Helpers
    
    /// Datasource Related
    
    /// UI Related
    
    //*****************************************************
    // MARK: Initializers & DeInitializers
    //*****************************************************
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addViews()
        self.initialUISetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        
    }
}


//************************************************
// MARK: Overided funtions (Defaults and Customs)
//************************************************

extension AppList_cell {
    
    //************************************************
    // MARK: Defaults
    //************************************************
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        
        guard newWindow != nil else {
            return
        }
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        
        guard window != nil else {
            return
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}


//*****************************************************
// MARK: Selectors
//*****************************************************

extension AppList_cell {
    
}


//************************************************
// MARK: Custom Funtions
//************************************************

extension AppList_cell {
    
    public func configure(from app: ModelApp) {
        self.imgvArtwork.loadImageFrom(app.artworkUrl100)
        self.lblName.text = app.name
        self.lblGenreDetails.text = app.commaSeparatedGenersName
        self.lblReleaseDate.text = app.releaseDate
    }
    
    private func initialUISetup() {
        self.backgroundColor = UIColor.white
    }
}


//************************************************
// MARK: ProgramaticallyCreatable
//************************************************

extension AppList_cell : ProgramaticallyCreatable {
    
    func addViews() {
        defer {
            self.setupConstraints()
        }
        
        self.addSubview(baseView)
        self.baseView.addSubview(imgvArtwork)
        self.baseView.addSubview(lblName)
        self.baseView.addSubview(lblGenreDetails)
        self.baseView.addSubview(lblReleaseDate)
    }
    
    func setupConstraints() {
        
        self.baseView.snp.makeConstraints { (maker) in
            maker.top.left.right.equalToSuperview()
            maker.bottom.equalToSuperview().space(S_WidthPerc: 2)
        }
        
        self.imgvArtwork.snp.remakeConstraints { (maker) in
            maker.top.left.right.equalToSuperview()
            maker.height.equalToSuperview().multipliedBy(0.7)
            
        }

        self.lblName.snp.remakeConstraints { (maker) in
            maker.top.equalTo(self.imgvArtwork.snp.bottom).space(S_WidthPerc: 1.3)
            maker.left.equalToSuperview().space(S_WidthPerc: 1)
            maker.right.equalToSuperview().space(S_WidthPerc: 1)
        }
        
        self.lblGenreDetails.snp.remakeConstraints { (maker) in
            maker.top.equalTo(self.lblName.snp.bottom).space(S_WidthPerc: 0.5)
            maker.left.equalToSuperview().space(S_WidthPerc: 1)
            maker.right.equalToSuperview().space(S_WidthPerc: 1)
        }

        self.lblReleaseDate.snp.remakeConstraints { (maker) in
            maker.top.equalTo(self.lblGenreDetails.snp.bottom).space(S_WidthPerc: 0.5)
            maker.left.equalToSuperview().space(S_WidthPerc: 1)
            maker.right.equalToSuperview().space(S_WidthPerc: 1)
        }
        
    }
}



















