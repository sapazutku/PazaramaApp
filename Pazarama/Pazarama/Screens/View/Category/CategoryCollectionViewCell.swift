//
//  CategoryTableView.swift
//  Pazarama
//
//  Created by utku on 25.10.2022.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "Category"
    
    
    let categoryTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(categoryTitle)
        //categoryTitle.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        //categoryTitle.center = contentView.center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        categoryTitle.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
    }
    
}
