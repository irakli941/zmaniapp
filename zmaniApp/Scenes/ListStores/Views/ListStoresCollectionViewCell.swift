//
//  ListStoresCollectionViewCell.swift
//  DonnaApp
//
//  Created by Irakli on 11/17/19.
//  Copyright © 2019 Irakli. All rights reserved.
//

import Foundation
import UIKit

class ListStoresCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var title: UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }
    
    public func configure(with store: ListStores.FetchStores.ViewModel.DisplayedStore)
    {
        imageView.image = UIImage.init(named: store.image)
        title.text = store.title
    }
    
}
