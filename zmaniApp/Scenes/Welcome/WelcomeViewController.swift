//
//  WelcomeViewController.swift
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

protocol WelcomeDisplayLogic: class
{
  func displayLogin(viewModel: Welcome.Login.ViewModel)
}

class WelcomeViewController: UIViewController, WelcomeDisplayLogic
{
  var interactor: WelcomeBusinessLogic?
  var router: (NSObjectProtocol & WelcomeRoutingLogic & WelcomeDataPassing)?

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
    let interactor = WelcomeInteractor()
    let presenter = WelcomePresenter()
    let router = WelcomeRouter()
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
    login()
  }
  
  // MARK: Do something
  
  //@IBOutlet weak var nameTextField: UITextField!
  
  func login()
  {
    let request = Welcome.Login.Request(email: "admin", password: "admin")
    interactor?.login(request: request)
  }
  
  func displayLogin(viewModel: Welcome.Login.ViewModel)
  {
    //nameTextField.text = viewModel.name
  }
}
