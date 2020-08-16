//
//  AppDelegate.swift
//  Geidea
//
//  Created by Bharat Shankar on 16/08/20.
//  Copyright © 2020 geidea. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        #if targetEnvironment(simulator)
        Bundle(path: "/Applications/InjectionIII.app/Contents/Resources/iOSInjection.bundle")?.load()
        #endif
        
        self.setupRootController()
        
        return true
    }
    
    private func setupRootController() {
        
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController.init(rootViewController: AppList_vc())
        window?.makeKeyAndVisible()
    }
}

