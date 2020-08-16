//
//  AppList_vc.swift
//  Geidea
//
//  Created by Bharat Shankar on 16/08/20.
//  Copyright © 2020 geidea. All rights reserved.
//


import UIKit

class AppList_vc: Base_vc {
    
    //************************************************
    // MARK: Programatic view properties
    //************************************************
    
    lazy private var baseView : UIView = {
        let this = UIView()
        return this
    }()
    
    lazy private var clnAppList : UICollectionView = {
        let layout : UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = verticalSpaceBetweenCells
        layout.minimumInteritemSpacing = verticalSpaceBetweenCells
        
        let this = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        this.register(AppList_cell.self, forCellWithReuseIdentifier: AppList_cell.className)
        this.delegate = self
        this.dataSource = self
        this.backgroundColor = UIColor.white
        
        return this
    }()
    
    
    //************************************************
    // MARK: Properties
    //************************************************
    
    /// Helpers
    
    /// Properties to manage cell size and spacing
    private let numberOfItemsPerRow:CGFloat = 2
    private let verticalSpaceBetweenCells : CGFloat = UIScreen.widthInPer(2)
    private let horizontalSpaceBetweenCells : CGFloat = UIScreen.widthInPer(2)
    
    /// Datasource Related
    
    private lazy var vm: AppList_vm = {
        let this: AppList_vm = AppList_vm()
        this.delegate = self
        return this
    }()
    
    /// UI Related
    
    //*****************************************************
    // MARK: Initializers & DeInitializers
    //*****************************************************
    
    init() {
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

extension AppList_vc {
    
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
        self.title = "App list"
    }
    
    override func initialUISetup() {
        self.view.backgroundColor = UIColor.white
    }
    
    override func initialDataSetup() {
        self.baseView.showActivityLoader()
        self.vm.fetchApps()
    }
}


//*****************************************************
// MARK: Selectors
//*****************************************************

extension AppList_vc {
    
}


//************************************************
// MARK: Custom Funtions
//************************************************

extension AppList_vc {
    
}


//***************************************************************************
// MARK: AppList_vm_delegate
//***************************************************************************

extension AppList_vc: AppList_vm_delegate {
    
    func appsDidUpdated() {
        self.baseView.hideActivityLoader()
        self.clnAppList.reloadData()
    }
    
    func didFailedToFetchApps(_ error: Error) {
        self.baseView.hideActivityLoader()
        UIAlertController.show(withTitle: "Error", andMessage: error.localizedDescription)
    }
}


//***************************************************************************
// MARK: UICollectionViewDelegate & UICollectionViewDataSource
//***************************************************************************

extension AppList_vc : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vm.arrApp.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: AppList_cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppList_cell.className, for: indexPath) as! AppList_cell
     
        let app: ModelApp = vm.arrApp[indexPath.row]
            
        cell.configure(from: app)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let app: ModelApp = vm.arrApp[indexPath.row]
        
        let vm: AppDetails_vm = AppDetails_vm.init(withApp: app)
        
        let vc: AppDetails_vc = AppDetails_vc.init(with: vm)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


//************************************************
// MARK: UICollectionViewDelegateFlowLayout
//************************************************

extension AppList_vc : UICollectionViewDelegateFlowLayout {
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        let totalSpacing = (2 * self.verticalSpaceBetweenCells) + ((numberOfItemsPerRow - 1) * horizontalSpaceBetweenCells)
        
        let width = (collectionView.bounds.width - totalSpacing)/numberOfItemsPerRow
        return CGSize(width: width + (self.verticalSpaceBetweenCells/(numberOfItemsPerRow/2)), height: UIScreen.widthInPer(60))
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) -> Void in
            // Skipped
            
        }, completion: {  [weak self] (UIViewControllerTransitionCoordinatorContext) -> Void in
            //refresh view once rotation is completed not in will transition as it returns incorrect frame size.Refresh here
            
            guard let this = self else { return }
            
            DispatchQueue.main.async {
                this.clnAppList.reloadData()
            }
        })
        
        super.viewWillTransition(to: size, with: coordinator)
    }
}


//************************************************
// MARK: ProgramaticallyCreatable
//************************************************

extension AppList_vc : ProgramaticallyCreatable {
    
    func addViews() {
        defer {
            self.setupConstraints()
        }
        
        self.view.addSubview(baseView)
        self.baseView.addSubview(clnAppList)
    }
    
    func setupConstraints() {
        
        self.baseView.snp.remakeConstraints { (maker) in
            maker.edges.equalTo(self.view.snpSafeArea.edges)
        }

        self.clnAppList.snp.remakeConstraints { (maker) in
            maker.center.equalToSuperview()
            maker.width.equalToSuperview().multipliedBy(0.95)
            maker.height.equalToSuperview().multipliedBy(0.95)
        }
    }
}





