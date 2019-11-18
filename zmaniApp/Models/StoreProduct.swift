//
//  StoreProduct.swift
//  zmaniApp
//
//  Created by Irakli on 11/18/19.
//  Copyright © 2019 Irakli. All rights reserved.
//

import Foundation

struct StoreProduct {
    
    enum Category {
        case Shoe
        case Jewellery
        case Shirt
        case Dress
        case Jeans
        case Accessories
    }
    
    enum Size {
        case S
        case M
        case L
        case XL
        case XXL
    }
    
    enum Sex {
        case F
        case M
        case U
    }
    
    
    var name: String
    var image: String
    var price: Double
    var size: Size
    var Sex: Sex
    var discountedPrice: Double?
    var discount: Int?
    var category: [Category]
    
    static let DummyStoreProducts = [
        StoreProduct(name: "T-Shirt", image: "shirt", price: 100, size: .M, Sex: .M, discountedPrice: 50, discount: 50, category: [.Shirt]),
        StoreProduct(name: "T-Shirt", image: "shirt", price: 100, size: .M, Sex: .M, discountedPrice: 100, discount: 70, category: [.Shirt]),
        StoreProduct(name: "T-Shirt", image: "shirt", price: 30, size: .M, Sex: .M, discountedPrice: 15, discount: 50, category: [.Shirt])
    ]
}
