//
//  ListStoreProductsViewControllerTests.swift
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

class ListStoreProductsViewControllerTests: XCTestCase
{
    // MARK: Subject under test
    
    var sut: ListStoreProductsViewController!
    var window: UIWindow!
    
    // MARK: Test lifecycle
    
    override func setUp()
    {
        super.setUp()
        window = UIWindow()
        setupListStoreProductsViewController()
    }
    
    override func tearDown()
    {
        window = nil
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupListStoreProductsViewController()
    {
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        sut = (storyboard.instantiateViewController(withIdentifier: "ListStoreProductsViewController") as! ListStoreProductsViewController)
    }
    
    func loadView()
    {
        window.addSubview(sut.view)
        sut.preloadView()
    }
    
    // MARK: Test doubles
    
    class ListStoreProductsBusinessLogicSpy: ListStoreProductsBusinessLogic
    {
        var fetchStoreProductsCalled = false
        
        func fetchStoreProducts(request: ListStoreProducts.FetchStoreProducts.Request) {
            fetchStoreProductsCalled = true
        }
    }
    
    class ListStoreProductsTableViewSpy: UITableView
    {
        var reloadDataCalled = false
        
        override func reloadData() {
            reloadDataCalled = true
        }
    }
    
    // MARK: Tests
    
    func testShouldFetchProductsWhenViewIsLoaded()
    {
        // Given
        let spy = ListStoreProductsBusinessLogicSpy()
        sut.interactor = spy
        
        // When
        sut.fetchStoreProducts(forStore: "zara")
        
        // Then
        XCTAssertTrue(spy.fetchStoreProductsCalled, "fetchStoreProducts() should ask interactor to fetchStoreProducts when view is loaded")
    }
    
    func testFetchStoresShouldReloadData()
    {
        // Given
        let tableView = ListStoreProductsTableViewSpy()
        sut.tableView = tableView
        let viewModel = ListStoreProducts.FetchStoreProducts.ViewModel(displayedStoreProducts: ListStoreProducts.FetchStoreProducts.ViewModel.DummyDisplayedStoreProducts)
        
        // When
        sut.displayProducts(viewModel: viewModel)
        
        // Then
        XCTAssertTrue(tableView.reloadDataCalled, "displayStoreProducts() should reloadData")
    }
    
    func testTableViewRowsShouldEqualToNumberOfFetchedStoreProducts()
    {
        // Given
        loadView()
        sut.fetchedProducts = ListStoreProducts.FetchStoreProducts.ViewModel.DummyDisplayedStoreProducts
        
        // When
        let numberOfRows = sut.tableView.numberOfRows(inSection: 0)
        let numberOfFetchedProducts = sut.fetchedProducts!.count
        
        // Then
        XCTAssertEqual(numberOfRows, numberOfFetchedProducts, "number of rows in section 0 should be equal to fetched products")
    }
    
}
