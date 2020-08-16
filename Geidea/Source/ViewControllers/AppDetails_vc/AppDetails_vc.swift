//
//  AppDetails_vc.swift
//  Geidea
//
//  Created by Bharat Shankar on 15/08/20.
//  Copyright © 2020 geidea. All rights reserved.
//

import UIKit

class DebugController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.test()
    }

    private func test() {
//        let vc = AppDetails_vc()
//        self.navigationController?.pushViewController(vc, animated: false)
    }

    @objc func injected() {
        self.navigationController?.popViewController(animated: false)
    }
}


class AppDetails_vc: Base_vc {
    
    //************************************************
    // MARK: Programatic view properties
    //************************************************
    
    lazy private var baseView : UIView = {
        let this = UIView()
        return this
    }()
    
    lazy private var imgvArtwork : UIImageView = {
        let this : UIImageView = UIImageView()
        this.contentMode = .scaleAspectFit
        this.clipsToBounds = true
        this.backgroundColor = UIColor.white
        return this
    }()
    
    lazy private var txtvDetails : AttributedTextView = {
        let this: AttributedTextView = AttributedTextView()
        return this
    }()
    
    //************************************************
    // MARK: Properties
    //************************************************
    
    /// Helpers
    
    /// Datasource Related
    
    let vm: AppDetails_vm
    
    /// UI Related
    
    //*****************************************************
    // MARK: Initializers & DeInitializers
    //*****************************************************
    
    init(with vm: AppDetails_vm) {
        self.vm = vm
        super.init(nibName: nil, bundle: nil)
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

extension AppDetails_vc {
    
    //************************************************
    // MARK: Defaults
    //************************************************
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addViews()
        self.initialUISetup()
        self.initialDataSetup()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    
    //************************************************
    // MARK: Overrided Funtions (from base class)
    //************************************************
    
    override func setupHeader() {
        self.title = self.vm.appName
    }
    
    override func initialDataSetup() {
        
        /// This will inform when user tapped  on clickable strings
        self.vm.delegate = self
        
        /// Setup attributer to textview
        self.txtvDetails.attributer = self.vm.appDetailsAttributer
        
        /// Setup App image
        self.imgvArtwork.loadImageFrom(self.vm.appImageURLString)
    }
    
    override func initialUISetup() {
        self.view.backgroundColor = UIColor.white
    }
}


//*****************************************************
// MARK: Selectors
//*****************************************************

extension AppDetails_vc {
    
}


//************************************************
// MARK: Custom Funtions
//************************************************

extension AppDetails_vc {
    
}


//************************************************
// MARK: AppDetails_vm_delegate
//************************************************

extension AppDetails_vc: AppDetails_vm_delegate {
    
    func didTappedOnArtistName(name: String, url: URL) {
        UIApplication.shared.open(url)
    }
    
    func didTappedOnDownloadNow(name: String, url: URL) {
        UIApplication.shared.open(url)
    }
}


//************************************************
// MARK: ProgramaticallyCreatable
//************************************************

extension AppDetails_vc : ProgramaticallyCreatable {
    
    func addViews() {
        defer {
            self.setupConstraints()
        }
        
        self.view.addSubview(baseView)
        self.baseView.addSubview(imgvArtwork)
        self.baseView.addSubview(txtvDetails)
    }
    
    func setupConstraints() {
        
        self.baseView.snp.remakeConstraints { (maker) in
            maker.edges.equalTo(self.view.snpSafeArea.edges)
        }
        
        self.imgvArtwork.snp.remakeConstraints { (maker) in
            maker.top.equalToSuperview().space(S_WidthPerc: 6)
            maker.left.right.equalToSuperview()
            maker.height.equalToSuperview().multipliedBy(0.4)
        }
        
        self.txtvDetails.snp.remakeConstraints { (maker) in
            maker.top.equalTo(self.imgvArtwork.snp.bottom).space(S_WidthPerc: 10)
            maker.centerX.bottom.equalToSuperview()
            maker.width.equalToSuperview().multipliedBy(0.95)
        }
    }
}






