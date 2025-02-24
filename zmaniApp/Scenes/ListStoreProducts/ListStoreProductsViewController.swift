//
//  ListStoreProductsViewController.swift
//  zmaniApp
//
//  Created by Irakli on 11/18/19.
//  Copyright (c) 2019 Irakli. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol ListStoreProductsDisplayLogic: class
{
    func displayProducts(viewModel: ListStoreProducts.FetchStoreProducts.ViewModel)
}

class ListStoreProductsViewController: UIViewController, ListStoreProductsDisplayLogic
{
    @IBOutlet var tableView: UITableView!
    
    var interactor: ListStoreProductsBusinessLogic?
    var router: (NSObjectProtocol & ListStoreProductsRoutingLogic & ListStoreProductsDataPassing)?
    var fetchedProducts: [ListStoreProducts.FetchStoreProducts.ViewModel.DisplayedStoreProduct]?
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
        let interactor = ListStoreProductsInteractor()
        let presenter = ListStoreProductsPresenter()
        let router = ListStoreProductsRouter()
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
        configureTableView()
        fetchStoreProducts(forStore: "zara")
    }
    
    private func configureTableView()
    {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        
    }
    
    func fetchStoreProducts(forStore store:String)
    {
        let request = ListStoreProducts.FetchStoreProducts.Request(store: store)
        interactor?.fetchStoreProducts(request: request)
    }
    
    
    func displayProducts(viewModel: ListStoreProducts.FetchStoreProducts.ViewModel)
    {
        fetchedProducts = viewModel.displayedStoreProducts
        tableView.reloadData()
    }
}

extension ListStoreProductsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fetchedProducts?.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListStoreProductsCell") as! ListStoreProductCell
        cell.configure(withProduct: fetchedProducts![indexPath.row])
        return cell
    }
    
}

extension ListStoreProductsViewController: UITableViewDelegate {
    
}
