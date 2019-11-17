//
//  ListStoresViewControllerTests.swift
//  DonnaApp
//
//  Created by Irakli on 11/15/19.
//  Copyright (c) 2019 Irakli. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

@testable import zmani
import XCTest

class ListStoresViewControllerTests: XCTestCase
{
    // MARK: Subject under test
    
    var sut: ListStoresViewController!
    var window: UIWindow!
    
    // MARK: Test lifecycle
    
    override func setUp()
    {
        super.setUp()
        window = UIWindow()
        setupListStoresViewController()
    }
    
    override func tearDown()
    {
        window = nil
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupListStoresViewController()
    {
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        sut = (storyboard.instantiateViewController(withIdentifier: "ListStoresViewController") as! ListStoresViewController)
    }
    
    func loadView()
    {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }
    
    // MARK: Test doubles
    
    class ListStoresBusinessLogicSpy: ListStoresBusinessLogic
    {
        var fetchStoresCalled = false
        
        func fetchStores(request: ListStores.FetchStores.Request) {
            fetchStoresCalled = true
        }
        
    }
    
    class CollectionViewSpy: UICollectionView
    {
        var reloadDataCalled = false
        
        override func reloadData() {
            reloadDataCalled = true
        }
        
    }
        
    // MARK: Test
    func testShouldFetchStoresWhenViewWillAppear()
    {
        // Given
        let spy = ListStoresBusinessLogicSpy()
        sut.interactor = spy
        
        // When
        loadView()
        
        // Then
        XCTAssertTrue(spy.fetchStoresCalled, "viewWillAppear should call fetchStores:")
    }
    
    func testFetchStoresShouldReloadData()
    {
     
        // Given
        let interactor = ListStoresBusinessLogicSpy()
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.itemSize = CGSize(width: 100, height: 100)
        let collectionViewSpy = CollectionViewSpy(frame: sut.view.frame, collectionViewLayout:  collectionViewLayout)
        sut.storesCollectionView = collectionViewSpy
        sut.interactor = interactor
        
        // When
        loadView()
        
        // Then
    //TODO TEST VIEWCONTROLLER
//        XCTAssertTrue(collectionViewSpy.reloadDataCalled, "fetchStores: should reload data")
        
    }
    
//    func testNumberOfRowsShouldBeEqualToNumberOfFetchedStores()
//    {
//        // Given
//        let spy = ListStoresBusinessLogicSpy()
//        sut.interactor = spy
//        sut.storesCollectionView.
////        spy.stores
//
//    }
    
}

