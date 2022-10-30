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
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 25)
        label.textColor = .white

        label.textAlignment = .natural
        return label
    }()

    let categoryImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        // shadow
        image.layer.shadowColor = UIColor.black.cgColor
        image.layer.shadowOffset = CGSize(width: 0, height: 0)
        image.layer.shadowRadius = 10
        image.layer.shadowOpacity = 0.5
        image.layer.masksToBounds = false
        image.layer.cornerRadius = 10

        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(categoryTitle)
        addSubview(categoryImage)
        //categoryTitle.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        //categoryTitle.center = contentView.center
        categoryTitle.translatesAutoresizingMaskIntoConstraints = false
        categoryTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        categoryTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        categoryTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        categoryTitle.heightAnchor.constraint(equalToConstant: 30).isActive = true

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        categoryTitle.frame = CGRect(x: frame.width / 2.5, y: frame.height - 20, width: frame.width , height: 150)

        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
        layer.cornerRadius = 10
        categoryImage.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height )
        bringSubviewToFront(categoryTitle)
        categoryImage.center = contentView.center


    }
    
}
