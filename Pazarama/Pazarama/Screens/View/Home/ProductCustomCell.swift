//
//  ProductCustomCell.swift
//  Pazarama
//
//  Created by utku on 26.10.2022.
//

import UIKit


class ProductCustomCell: UICollectionViewCell {
    
  
    
    let bg: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 12
        return iv
    }()

    let lbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        lbl.textColor = .black
        lbl.textAlignment = .center
        return lbl
    }()
    
    let price: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont(name: "HelveticaNeue-Bold", size: 25)
        lbl.textColor = .systemRed
        lbl.textAlignment = .center
        return lbl
    }()

    let addToCart: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Add to Cart", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .systemIndigo
        btn.layer.cornerRadius = 12
        return btn
    }()




    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        // image
        contentView.addSubview(bg)
        bg.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        
        // title
        contentView.addSubview(lbl)
        lbl.frame = CGRect(x: 0, y: 200, width: 200, height: 50)

        // price
        contentView.addSubview(price)
        price.frame = CGRect(x: 0, y: 0, width: 100, height: 100)

        // button
        contentView.addSubview(addToCart)
        addToCart.frame = CGRect(x: 25, y: 250, width: 150, height: 40)

        // cell border
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.layer.cornerRadius = 12
        

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
