//
//  ProductsCollectionViewCell.swift
//  Pazarama
//
//  Created by utku on 26.10.2022.
//

import Foundation

class ProductsCollectionViewCell: UICollectionViewCell {
    static let identifier = "ProductCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemBlue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
