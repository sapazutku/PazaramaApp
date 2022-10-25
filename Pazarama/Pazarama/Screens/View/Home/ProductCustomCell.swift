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
    



    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        contentView.addSubview(bg)
        
        bg.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        bg.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        bg.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        bg.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        contentView.addSubview(lbl)

        lbl.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        lbl.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        lbl.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        lbl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true

        // add cell border
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.layer.cornerRadius = 12
        

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
