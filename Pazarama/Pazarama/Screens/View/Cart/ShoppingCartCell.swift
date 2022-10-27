 //
 //  ShoppingChartCell.swift
 //  Pazarama
 //
 //  Created by utku on 27.10.2022.
 //

 import Foundation
 import UIKit
 import SnapKit

 class ShoppingCartCell: UITableViewCell {
     static let identifier = "ShoppingChartCell"
     
     // MARK: - Components
     // item image
     private let itemImageView: UIImageView = {
         let imageView = UIImageView()
         imageView.contentMode = .scaleAspectFit
         imageView.clipsToBounds = true
         imageView.layer.cornerRadius = 10
         return imageView
     }()
     // item name
     private let itemNameLabel: UILabel = {
         let label = UILabel()
         label.text = "Item Name"
         label.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
         label.textColor = .black
         return label
     }()
     // item price
     private let itemPriceLabel: UILabel = {
         let label = UILabel()
         label.text = "Item Price"
         label.font = UIFont(name: "HelveticaNeue", size: 16)
         label.textColor = .black
         return label
     }()
     // item quantity
     private let itemQuantityLabel: UILabel = {
         let label = UILabel()
         label.text = "Item Quantity"
         label.font = UIFont(name: "HelveticaNeue", size: 16)
         label.textColor = .black
         return label
     }()
     // MARK: - Lifecycle
     override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: style, reuseIdentifier: reuseIdentifier)
         configureUI()
     }
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
     // MARK: - Helpers
     func configureUI() {
         backgroundColor = .systemBackground
         addSubview(itemImageView)
         itemImageView.snp.makeConstraints { make in
             make.top.equalToSuperview().offset(10)
             make.left.equalToSuperview().offset(10)
             make.width.equalTo(100)
             make.height.equalTo(100)
         }
         addSubview(itemNameLabel)
         itemNameLabel.snp.makeConstraints { make in
             make.top.equalToSuperview().offset(10)
             make.left.equalTo(itemImageView.snp.right).offset(10)
         }
         addSubview(itemPriceLabel)
         itemPriceLabel.snp.makeConstraints { make in
             make.top.equalTo(itemNameLabel.snp.bottom).offset(10)
             make.left.equalTo(itemImageView.snp.right).offset(10)
         }
         addSubview(itemQuantityLabel)
         itemQuantityLabel.snp.makeConstraints { make in
             make.top.equalTo(itemPriceLabel.snp.bottom).offset(10)
             make.left.equalTo(itemImageView.snp.right).offset(10)
         }
     }
 }
