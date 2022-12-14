//
//  ProductCustomCell.swift
//  Pazarama
//
//  Created by utku on 26.10.2022.
//

import UIKit
import CoreData
import Drops
class ProductCustomCell: UICollectionViewCell {

    var product: Product? {
        didSet {
            guard let product = product else { return }
            bg.downloadImage(from: URL(string: product.image)!)
            lbl.text = product.title
            price.text = String(product.price) + " ₺"
            star.text = String(product.rating.rate) + " ⭐️"
        }
    }
    
    // alert
    
    let drop = Drop(title: "Added to Cart",  icon: UIImage(systemName: "checkmark"))
    
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

    // star
    var star: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont(name: "HelveticaNeue", size: 20)
        lbl.textColor = .black
        lbl.textAlignment = .center
        return lbl
    }()




    // button
    var addToCart: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
       
        btn.setImage(UIImage(systemName: "cart.badge.plus")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        btn.setTitleColor(.white, for: .normal)
        //btn.setTitle("Add to ", for: .normal)
       
        btn.backgroundColor = .systemPink
        btn.layer.cornerRadius = 10
        btn.addTarget(self, action: #selector(addToCartAction), for: .touchUpInside)
        return btn
    }()




    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        // image
        contentView.addSubview(bg)
        bg.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        
        // title
        contentView.addSubview(lbl)
        lbl.frame = CGRect(x: 0, y: 150, width: 150, height: 50)

        // price
        contentView.addSubview(price)
        price.frame = CGRect(x: 75, y: lbl.frame.origin.y + 20, width: 100, height: 100)

        // star
        contentView.addSubview(star)
        star.frame = CGRect(x: 0, y: lbl.frame.origin.y + 20, width: 100, height: 100)

        // button
        contentView.addSubview(addToCart)
        addToCart.frame = CGRect(x: 20, y: 250, width: 120, height: 30)

        
        

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods
    @objc func addToCartAction() {
        Product.addProduct(product: product!)
        Drops.show(drop)
    }
}
