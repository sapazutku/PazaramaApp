//
//  ShoppingChartViewController.swift
//  Pazarama
//
//  Created by utku on 25.10.2022.
//

import UIKit
import SnapKit
class ShoppingChartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingChartTableViewCell", for: indexPath) as! ShoppingChartTableViewCell
        return cell
    }
    

    // MARK: - Properties

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
        tableView.register(ShoppingChartTableViewCell.self, forCellReuseIdentifier: ShoppingChartTableViewCell.identifier)
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
        button.backgroundColor = .systemBlue
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
        
    }

    // MARK: - Actions

    @objc func buyButtonTapped() {
        print("buy button tapped")
    }

}



