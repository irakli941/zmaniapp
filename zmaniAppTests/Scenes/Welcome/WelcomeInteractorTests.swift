//
//  WelcomeInteractorTests.swift
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

class WelcomeInteractorTests: XCTestCase
{
    // MARK: Subject under test
    
    var sut: WelcomeInteractor!
    
    // MARK: Test lifecycle
    
    override func setUp()
    {
        super.setUp()
        setupWelcomeInteractor()
    }
    
    override func tearDown()
    {
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupWelcomeInteractor()
    {
        sut = WelcomeInteractor()
    }
    
    // MARK: Test doubles
    
    class WelcomePresentationLogicSpy: WelcomePresentationLogic
    {
        var presentLoginCalled = false
        var presentLoginResponse: Welcome.Login.Response!
        
        func presentLogin(response: Welcome.Login.Response)
        {
            presentLoginCalled = true
            presentLoginResponse = response
        }
    }
    
    class WelcomeWorkerDummy: WelcomeWorker
    {
        override func login(email: String, password: String, completionHandler: @escaping (Bool) -> Void) {
            completionHandler(false)
        }
    }
    
    // MARK: Tests
    
    func testLoginShouldAskPresenterToFormatResult ()
    {
        // Given
        let spy = WelcomePresentationLogicSpy()
        sut.presenter = spy
        let dummy = WelcomeWorkerDummy()
        sut.worker = dummy
        let request = Welcome.Login.Request(email: "any", password: "any")
        
        // When
        sut.login(request: request)
        
        // Then
        XCTAssertTrue(spy.presentLoginCalled, "login(request:) should ask the presenter to format the result")
    }
    
    
    class WelcomeWorkerSpy: WelcomeWorker
    {
        var loginCalled = false
        
        override func login(email: String, password: String, completionHandler: @escaping (Bool) -> Void) {
            loginCalled = true
            completionHandler(true)
        }
        
    }
    
    func testLoginShouldAskWorkerToLoginUsingSpy()
    {
        // Given
        let spy = WelcomeWorkerSpy()
        sut.worker = spy
        
        // When
        let request = Welcome.Login.Request(email: "admin", password: "admin")
        sut.login(request: request)
        
        // Then
        XCTAssertTrue(spy.loginCalled, "login(request:) should ask the worker to login")
    }
    
    // MARK: Fake
    
    class WelcomeWorkerFake: WelcomeWorker
    {
        override func login(email: String, password: String, completionHandler: @escaping (Bool) -> Void) {
            if email == "admin" && password == "admin" {
                completionHandler(true)
            } else {
                completionHandler(false)
            }
        }
    }
    
    func testLoginShouldAllowToAuthenticateOnSuccess()
    {
        // Given
        let fake = WelcomeWorkerFake()
        sut.worker = fake
        let spy = WelcomePresentationLogicSpy()
        sut.presenter = spy
        let request = Welcome.Login.Request(email: "admin", password: "admin")
        
        // When
        sut.login(request: request)
        
        // Then
        XCTAssertTrue(spy.presentLoginResponse.success, "login(request:) with valid email and password should result in success")
        
    }
    
    func testLoginShouldRejectToAuthenticateOnFailure()
    {
        // Given
        let fake = WelcomeWorkerFake()
        let spy = WelcomePresentationLogicSpy()
        sut.worker = fake
        sut.presenter = spy
        let request = Welcome.Login.Request(email: "guest", password: "guest")
        
        // When
        sut.login(request: request)
        
        // Then
        XCTAssertFalse(spy.presentLoginResponse.success, "login(request:) with invalid email and password should result in failure")
    }
    
}
