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
        return shoppingCart.count ?? .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "shoppingCell", for: indexPath) as! UITableViewCell
            cell.textLabel?.text = shoppingCart[indexPath.row].title
            cell.detailTextLabel?.text = String(shoppingCart[indexPath.row].price)
            // plus button 
            let plusButton = UIButton()
            plusButton.setTitle("+", for: .normal)
            plusButton.setTitleColor(.black, for: .normal)
            plusButton.backgroundColor = .white
            plusButton.layer.cornerRadius = 10
            plusButton.layer.borderWidth = 1
            plusButton.layer.borderColor = UIColor.black.cgColor
            plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
            cell.contentView.addSubview(plusButton)
            plusButton.snp.makeConstraints { make in
                make.top.equalTo(cell.contentView.snp.top).offset(25)
                make.right.equalTo(cell.contentView.snp.right).offset(-10)
                make.width.equalTo(30)
                make.height.equalTo(30)
            }

            // minus button
            let minusButton = UIButton()
            minusButton.setTitle("-", for: .normal)
            minusButton.setTitleColor(.black, for: .normal)
            minusButton.backgroundColor = .white
            minusButton.layer.cornerRadius = 10
            minusButton.layer.borderWidth = 1
            minusButton.layer.borderColor = UIColor.black.cgColor
            minusButton.addTarget(self, action: #selector(minusButtonTapped), for: .touchUpInside)
            cell.contentView.addSubview(minusButton)
            minusButton.snp.makeConstraints { make in
                make.top.equalTo(cell.contentView.snp.top).offset(25)
                make.right.equalTo(plusButton.snp.left).offset(-10)
                make.width.equalTo(30)
                make.height.equalTo(30)
            }

            // count label
            let countLabel = UILabel()
            countLabel.text = String(shoppingCart[indexPath.row].quantity)
            countLabel.textColor = .black
            countLabel.backgroundColor = .white
            countLabel.layer.cornerRadius = 10
            countLabel.layer.borderWidth = 0
            countLabel.textAlignment = .center
            cell.contentView.addSubview(countLabel)
            countLabel.snp.makeConstraints { make in
                make.top.equalTo(cell.contentView.snp.top).offset(25)
                make.right.equalTo(minusButton.snp.left).offset(-10)
                make.width.equalTo(30)
                make.height.equalTo(30)
            }


            return cell
    }
    
    var shoppingCart: [ProductItem] = []

    // table
    private let tableView = UITableView()

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
        getAllProducts()
        configureUI()

    }

    // MARK: - Helpers

    func configureUI() {
        // navigation item title
        navigationItem.title = "Shopping Chart"
        // 
        // table view
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "shoppingCell")
        tableView.rowHeight = 70
        tableView.tableFooterView = UIView()
        // add row to button

        
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-200)
        }
        view.backgroundColor = .systemBackground

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
            make.top.equalTo(totalPriceLabel.snp.bottom).offset(5)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(10)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-10)
            make.height.equalTo(50)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-10)
        }
        
    }

    // MARK: - Methods

    // get all products from core data
    func getAllProducts() {
        shoppingCart = Product.getAllProducts()
        print("Shopping Cart: \(shoppingCart)")
        reloadData()
    }

    // MARK: - Helpers
    func reloadData(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.totalItemLabel.text = "Total Item: \(self.shoppingCart.count)"
            self.totalPriceLabel.text = "Total Price: \(self.calculateTotalPrice())"
        }
    }

    func calculateTotalPrice() -> Double {
        var totalPrice = 0
        for item in shoppingCart {
            totalPrice += Int(item.price * Double(item.quantity))
        }
        return Double(totalPrice)
    }
    

    // MARK: - Selectors

    @objc func buyButtonTapped() {
        print("DEBUG: buy button tapped")
    }
    
    @objc func plusButtonTapped(_ sender: UIButton) {
        let cell = sender.superview?.superview as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)
        let product = shoppingCart[indexPath!.row]
        Product.plusProductQuantity(product: product)
        reloadData()
    }

    @objc func minusButtonTapped(_ sender: UIButton) {
        let cell = sender.superview?.superview as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)
        let product = shoppingCart[indexPath!.row]
        Product.minusProductQuantity(product: product)
        reloadData()
    }
    
}
