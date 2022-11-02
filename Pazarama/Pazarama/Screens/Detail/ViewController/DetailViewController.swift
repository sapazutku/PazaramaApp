//
//  DetailViewController.swift
//  Pazarama
//
//  Created by utku on 2.11.2022.
//

import Foundation
import UIKit
import SnapKit

class DetailViewController: UIViewController {
    // MARK: - Properties

    var product: Product?

    
    var shoppingCartViewModal = ShoppingCartViewModel()
    
    var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    var productTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var productPrice: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var productDescription: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var rating: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var addToCartButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add to Cart", for: .normal)
        button.backgroundColor = .systemPink
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(addToCartButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // navigation bar editing
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.backgroundColor = .systemBackground
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemBackground
        self.navigationItem.standardAppearance = appearance
        self.navigationItem.scrollEdgeAppearance = appearance
        self.navigationItem.compactAppearance = appearance
        
        view.backgroundColor = .white
        tabBarController?.tabBar.isHidden = true
        configureUI()
        
    }

    func configureUI() {
        
        view.addSubview(productImageView)
        productImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(10)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-10)
            make.height.equalTo(300)
        }
        productImageView.downloadImage(from: URL(string: product!.image))
        
        view.addSubview(productTitle)
        productTitle.snp.makeConstraints { make in
            make.top.equalTo(productImageView.snp.bottom).offset(10)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(10)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-10)
        }
        productTitle.text = product?.title

        view.addSubview(rating)
        rating.snp.makeConstraints { make in
            make.top.equalTo(productTitle.snp.bottom).offset(10)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(10)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-10)
        }
        rating.text = "\(product!.rating.rate)" + " ⭐️ " + " (\(product!.rating.count))"
        
        view.addSubview(productPrice)
        productPrice.snp.makeConstraints { make in
            make.top.equalTo(rating.snp.bottom).offset(10)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(10)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-10)
        }
        productPrice.text = String(format: "%.2f", product!.price)
        
        view.addSubview(productDescription)
        productDescription.snp.makeConstraints { make in
            make.top.equalTo(productPrice.snp.bottom).offset(10)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(10)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-10)
        }
        productDescription.text = product?.description
        
        view.addSubview(addToCartButton)
        addToCartButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-10)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(10)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-10)
            make.height.equalTo(50)
        }
    }

    
    // MARK: - Actions
    @objc func addToCartButtonTapped(_ sender: Any) {
        Product.addProduct(product: product!)
    }
}
