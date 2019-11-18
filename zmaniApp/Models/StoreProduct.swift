//
//  StoreProduct.swift
//  zmaniApp
//
//  Created by Irakli on 11/18/19.
//  Copyright © 2019 Irakli. All rights reserved.
//

import Foundation

struct Product {
    
    enum Category {
        case Shoe
        case Jewellery
        case Shirt
        case Dress
        case Jeans
        case Accessories
    }
    
    var name: String
    var image: String
    var price: Double
    var discount: Int
    var category: [Category]
    
}
