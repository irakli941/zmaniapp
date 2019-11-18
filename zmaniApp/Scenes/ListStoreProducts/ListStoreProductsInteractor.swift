//
//  ListStoreProductsInteractor.swift
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

protocol ListStoreProductsBusinessLogic
{
    func fetchStoreProducts(request: ListStoreProducts.FetchStoreProducts.Request)
}

protocol ListStoreProductsDataStore
{
    //var name: String { get set }
}

class ListStoreProductsInteractor: ListStoreProductsBusinessLogic, ListStoreProductsDataStore
{
    var presenter: ListStoreProductsPresentationLogic?
    var worker = ListStoreProductsWorker()
    
    func fetchStoreProducts(request: ListStoreProducts.FetchStoreProducts.Request)
    {
        worker.fetchProducts(forStore: request.store) { [weak self] (products) in
            let response = ListStoreProducts.FetchStoreProducts.Response(products: products)
            self?.presenter?.presentProducts(response: response)
        }
    }
}
