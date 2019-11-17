//
//  ListStoresViewController.swift
//  DonnaApp
//
//  Created by Irakli on 11/15/19.
//  Copyright (c) 2019 Irakli. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol ListStoresDisplayLogic: class
{
    func displayFetchedStores(viewModel: ListStores.FetchStores.ViewModel)
}

class ListStoresViewController: UIViewController, ListStoresDisplayLogic
{
    
    @IBOutlet var storesCollectionView: UICollectionView!
    
    var interactor: ListStoresBusinessLogic?
    var router: (NSObjectProtocol & ListStoresRoutingLogic & ListStoresDataPassing)?
    private var fetchedStores: [Store]?
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup()
    {
        let viewController = self
        let interactor = ListStoresInteractor()
        let presenter = ListStoresPresenter()
        let router = ListStoresRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        storesCollectionView!.dataSource = self
        storesCollectionView!.delegate = self
        fetchStores()
    }
    
    
    func fetchStores()
    {
        let request = ListStores.FetchStores.Request()
        interactor?.fetchStores(request: request)
    }
    
    func displayFetchedStores(viewModel: ListStores.FetchStores.ViewModel)
    {
        //nameTextField.text = viewModel.name
    }
    
}

extension ListStoresViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        fetchedStores?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListStoresCell", for: indexPath) as! ListStoresCollectionViewCell
        return cell
    }
}
