//
//  ListStoreProductsPresenterTests.swift
//  zmaniApp
//
//  Created by Irakli on 11/18/19.
//  Copyright (c) 2019 Irakli. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

@testable import zmani
import XCTest

class ListStoreProductsPresenterTests: XCTestCase
{
    // MARK: Subject under test
    
    var sut: ListStoreProductsPresenter!
    
    // MARK: Test lifecycle
    
    override func setUp()
    {
        super.setUp()
        setupListStoreProductsPresenter()
    }
    
    override func tearDown()
    {
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupListStoreProductsPresenter()
    {
        sut = ListStoreProductsPresenter()
    }
    
    // MARK: Test doubles
    
    class ListStoreProductsDisplayLogicSpy: ListStoreProductsDisplayLogic
    {
        
        var displayProductsCalled = false
        var viewModel: ListStoreProducts.FetchStoreProducts.ViewModel!
        func displayProducts(viewModel: ListStoreProducts.FetchStoreProducts.ViewModel)
        {
            displayProductsCalled = true
            self.viewModel = viewModel
        }
    }
    
    // MARK: Tests
    
    func testPresenProductsShouldAskViewControllerToDisplayProducts()
    {
        // Given
        let spy = ListStoreProductsDisplayLogicSpy()
        sut.viewController = spy
        let response = ListStoreProducts.FetchStoreProducts.Response(products: Seeds.DummyStoreProducts)
        
        // When
        sut.presentProducts(response: response)
        
        // Then
        XCTAssertTrue(spy.displayProductsCalled, "presentProducts(response:) should ask view controller to display products")
    }
    
    func testPresentProductsShouldFormatProductsForViewController()
    {
        // Given
        let spy = ListStoreProductsDisplayLogicSpy()
        sut.viewController = spy
        let response = ListStoreProducts.FetchStoreProducts.Response(products: Seeds.DummyStoreProducts)
        
        // When
        sut.presentProducts(response: response)
        
        // Then
        //        DisplayedStoreProduct(name: "T-Shirt", image: "shirt", price: 100, size: .M, Sex: .M, discountedPrice: 50, discount: 50, category: [.Shirt]),
        XCTAssertEqual(spy.viewModel.displayedStoreProducts.first?.name, "T-Shirt", "presenting fetched store products should properly format product name")
        //todo
    }
}

extension ListStoreProductsViewController {
    func preloadView() {
        let _ = view
    }
}
