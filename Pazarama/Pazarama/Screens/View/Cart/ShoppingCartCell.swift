//
//  ShoppingChartCell.swift
//  Pazarama
//
//  Created by utku on 27.10.2022.
//

import Foundation
import UIKit

class ShoppingCartCell: UITableViewCell {
    
    let identifier = "ShoppingCartCell"
    
    var product: Product? {
        didSet {
            guard let product = product else { return }
            bg.downloadImage(from: URL(string: product.image)!)
            lbl.text = product.title
            price.text = String(product.price) + " $"
            
        }
    }
    
    // image
    
    var bg: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 12
        return iv
    }()
    
    // title
    
    var lbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont(name: "HelveticaNeue", size: 20)
        lbl.textColor = .black
        lbl.textAlignment = .center
        return lbl
    }()
    
    // $
    
    var price: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont(name: "HelveticaNeue", size: 20)
        lbl.textColor = .systemRed
        lbl.textAlignment = .center
        return lbl
    }()
    
    
    // delete button
    var deleteButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Delete", for: .normal)
        btn.backgroundColor = .systemRed
        btn.layer.cornerRadius = 10
        return btn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(bg)
        contentView.addSubview(lbl)
        contentView.addSubview(price)
        
        contentView.addSubview(deleteButton)
        
        bg.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        bg.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        bg.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        bg.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        lbl.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        lbl.leadingAnchor.constraint(equalTo: bg.trailingAnchor, constant: 10).isActive = true
        lbl.widthAnchor.constraint(equalToConstant: 200).isActive = true
        lbl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        price.topAnchor.constraint(equalTo: lbl.bottomAnchor, constant: 10).isActive = true
        price.leadingAnchor.constraint(equalTo: bg.trailingAnchor, constant: 10).isActive = true
        price.widthAnchor.constraint(equalToConstant: 200).isActive = true
        price.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        
        deleteButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        deleteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        deleteButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        deleteButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


