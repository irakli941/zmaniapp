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
}
