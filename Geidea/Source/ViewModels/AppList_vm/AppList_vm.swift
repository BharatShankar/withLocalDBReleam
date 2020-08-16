//
//  AppList_viewModel.swift
//  Geidea
//
//  Created by Bharat Shankar on 15/08/20.
//  Copyright © 2020 geidea. All rights reserved.
//

import Foundation
import RealmSwift

protocol AppList_vm_delegate {
    func appsDidUpdated()
    func didFailedToFetchApps(_ error : Error)
}

class AppList_vm {
    
    private(set) var arrApp: [ModelApp] = []
    
    public var delegate : AppList_vm_delegate? = nil
    
    /// Helps to fetch or update visits as per date
    public func fetchApps() {
        APIManager.shared.fetchApps { (result) in
            switch result {
            case .success(let arrApp):
                self.arrApp = arrApp
                
                /// Storing it to local, optional try case as we can still show data to user if failed to save it to local, so for better user experience we'll not stop the flow if failed
                let realm = try? Realm()
                try? realm?.write { realm?.add(arrApp, update: .modified) }
                
                self.delegate?.appsDidUpdated()
            case .failure(let error):
                
                /// In case of any error, getting data from local if stored....
                if let realm = try? Realm() {
                    
                    let objects = realm.objects(ModelApp.self)
                    
                    if !objects.isEmpty {
                        
                        self.arrApp = Array(objects)
                        self.delegate?.appsDidUpdated()
                    } else {
                        self.delegate?.didFailedToFetchApps(error)
                    }
                    
                } else {
                    self.delegate?.didFailedToFetchApps(error)
                }
            }
        }
    }
}
