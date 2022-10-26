//
//  ShoppingChartViewController.swift
//  Pazarama
//
//  Created by utku on 25.10.2022.
//

import UIKit
import SnapKit
class ShoppingCartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingCartCell", for: indexPath) as! ShoppingCartCell
        return cell
    }
    


    // MARK: - Components
    // title
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Shopping Chart"
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        label.textColor = .black
        return label
    }()

    // table
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ShoppingCartCell.self, forCellReuseIdentifier: "ShoppingCartCell")
        tableView.backgroundColor = .systemBackground
        tableView.separatorStyle = .none
        return tableView
    }()

    // total item
    private let totalItemLabel: UILabel = {
        let label = UILabel()
        label.text = "Total Item: 0"
        label.font = UIFont(name: "HelveticaNeue", size: 16)
        label.textColor = .black
        return label
    }()

    // total price

    private let totalPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "Total Price: 0"
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        label.textColor = .black
        return label
    }()

    // buy button
    private let buyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Buy", for: .normal)
        button.backgroundColor = .systemPink
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(buyButtonTapped), for: .touchUpInside)
        return button
    }()



    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()

    }

    // MARK: - Helpers

    func configureUI() {
        view.backgroundColor = .systemBackground
                view.addSubview(titleLabel)
                titleLabel.snp.makeConstraints { make in
                    make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
                    make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(10)
                }

                view.addSubview(tableView)
                tableView.snp.makeConstraints { make in
                    make.top.equalTo(titleLabel.snp.bottom).offset(10)
                    make.left.equalTo(view.safeAreaLayoutGuide.snp.left)
                    make.right.equalTo(view.safeAreaLayoutGuide.snp.right)
                    make.height.equalTo(300)
                }

                view.addSubview(totalItemLabel)
                totalItemLabel.snp.makeConstraints { make in
                    make.top.equalTo(tableView.snp.bottom).offset(10)
                    make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(10)
                }

                view.addSubview(totalPriceLabel)
                totalPriceLabel.snp.makeConstraints { make in
                    make.top.equalTo(totalItemLabel.snp.bottom).offset(10)
                    make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(10)
                }

                view.addSubview(buyButton)
                buyButton.snp.makeConstraints { make in
                    make.top.equalTo(totalPriceLabel.snp.bottom).offset(10)
                    make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(10)
                    make.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-10)
                    make.height.equalTo(50)
                }
        
    }

    // MARK: - Ovveride
    

    // MARK: - Selectors

    @objc func buyButtonTapped() {
        print("DEBUG: buy button tapped")
    }


    

}
