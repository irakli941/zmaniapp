//
//  ListStoreProductCell.swift
//  zmaniApp
//
//  Created by Irakli on 11/18/19.
//  Copyright © 2019 Irakli. All rights reserved.
//

import Foundation
import UIKit

class ListStoreProductCell: UITableViewCell {
    
    @IBOutlet var productImageView: UIImageView!
    @IBOutlet var title: UILabel!
    @IBOutlet var size: UILabel!
    @IBOutlet var price: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func configure(withProduct product: ListStoreProducts.FetchStoreProducts.ViewModel.DisplayedStoreProduct)
    {
        productImageView.image = UIImage.init(named: product.image)
        title.text = product.name
        price.text = String(product.price)
    }
    
}
