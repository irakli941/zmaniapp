//
//  Seeds.swift
//  zmaniAppTests
//
//  Created by Irakli on 11/17/19.
//  Copyright © 2019 Irakli. All rights reserved.
//

import Foundation
@testable import zmani

struct Seeds {
    struct Stores {
        static let AnyStore = Store(name: "any", image: "any")
        static let DummyStores = [Store(name: "zara", image: "zara"),
                                  Store(name: "zara", image: "zara")
        ]
    }
    
    struct DisplayedStores {
        static let AnyStore = ListStores.FetchStores.ViewModel.DisplayedStore(title: "ZARA", image: "zara")
        static let DummyStores = [ ListStores.FetchStores.ViewModel.DisplayedStore(title: "Nike", image: "nike"),
                                   ListStores.FetchStores.ViewModel.DisplayedStore(title: "Adidas", image: "adidas"),
        ]
    }
    
    static let DummyStoreProducts = [
        StoreProduct(name: "T-Shirt", image: "shirt", price: 100, size: .M, Sex: .M, discountedPrice: 50, discount: 50, category: [.Shirt]),
        StoreProduct(name: "T-Shirt", image: "shirt", price: 100, size: .M, Sex: .M, discountedPrice: 100, discount: 70, category: [.Shirt]),
        StoreProduct(name: "T-Shirt", image: "shirt", price: 30, size: .M, Sex: .M, discountedPrice: 15, discount: 50, category: [.Shirt])
    ]
}
