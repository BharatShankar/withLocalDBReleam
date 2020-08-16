//
//  Base_vc.swift
//  Geidea
//
//  Created by Bharat Shankar on 16/08/20.
//  Copyright © 2020 geidea. All rights reserved.
//

import UIKit

/// All viewcontrollers will inherit to base
/// This will enable control to all viewcontrollers from a single place
class Base_vc: UIViewController {
    
    //************************************************
    // MARK: Properties
    //************************************************
    
    /// Helpers
    
    /// Helps to know when self is dismissed
    var handlerControllerDidDismiss : ((UIViewController) -> Void)? = nil
    
    /// Helps to know when self will pop to controller
    var handlerControllerWillPopped : ((UIViewController) -> Void)? = nil
    
    /// Helps to know when self did pop to controller
    var handlerControllerDidPopped : ((UIViewController) -> Void)? = nil
    
    /// Datasource Related
    
    /// UI Related
    
    //*****************************************************
    // MARK: Initializers & DeInitializers
    //*****************************************************
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("DEINIT ", self)
    }
}


//************************************************
// MARK: Overided funtions (Defaults and Customs)
//************************************************

extension Base_vc {
    
    //************************************************
    // MARK: Defaults
    //************************************************
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setupHeader()
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
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        super.dismiss(animated: flag, completion: completion)
        
        handlerControllerDidDismiss?(self)
    }
    
    override func willMove(toParent parent: UIViewController?) {
        if parent == nil {
            handlerControllerWillPopped?(self)
        }
        
        super.willMove(toParent: parent)
    }
    
    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        
        if parent == nil {
            handlerControllerDidPopped?(self)
        }
    }
    
    //************************************************
    // MARK: Dynamic Funtions
    //************************************************
    
    /// Helps to set header in child controllers, will get automatically called in childs
    @objc dynamic func setupHeader() {
        
    }
    
    /// Helps to set intialdata in child controllers, Need to call it from childs, as some childs don't set any data...
    @objc dynamic func initialDataSetup() {
        
    }
    
    /// Helps to set initial UI in child controllers, Need to call it from childs, as some childs don't set any UI...
    @objc dynamic func initialUISetup() {
        
    }
}
