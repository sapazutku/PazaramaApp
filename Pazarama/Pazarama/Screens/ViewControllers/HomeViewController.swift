//
//  ViewController.swift
//  Pazarama
//
//  Created by utku on 25.10.2022.
//

import UIKit
import Moya

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    
    
    //MARK: - Properties
    let provider = MoyaProvider<ProductsAPI>()

    var products = [Product]()
    var popularProducts = [Product]()
    

    // MARK: - UI Elements
    private let collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(ProductCustomCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()

    // best seller title
    private let topTitle : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Best Seller Products"
        lbl.font = UIFont(name: "HelveticaNeue-Bold", size: 25)
        lbl.textColor = .black
        return lbl
    }()

    // all products title
    private let allProductsTitle : UILabel = {
        let lbl = UILabel()
        lbl.text = "All Products"
        lbl.font = UIFont(name: "HelveticaNeue-Bold", size: 25)
        lbl.textColor = .black
        return lbl
    }()

    // all collection view
    private let allProductsCollectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(ProductCustomCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()

    //MARK: - Lifecycle
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // navigation bar
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.backgroundColor = .systemBackground
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemBackground
        self.navigationItem.standardAppearance = appearance
        self.navigationItem.scrollEdgeAppearance = appearance
        /*
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        */

        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        getProducts()
        
    }

    override func viewWillAppear (_ animated: Bool) {
        super.viewWillAppear(animated)
        view.addSubview(collectionView)
        view.addSubview(topTitle)
        view.addSubview(allProductsTitle)
        view.addSubview(allProductsCollectionView)
        configureUI()
    }

    func configureUI() {

        // best seller title
        topTitle.frame = CGRect(x: 20, y: 50, width: view.frame.width - 40, height: 30)

        // collection view
        collectionView.backgroundColor = .systemBackground
        collectionView.frame = CGRect(x: 20, y: 50, width: view.frame.width - 40, height: 300)
        collectionView.delegate = self
        collectionView.dataSource = self

        // all products title
        allProductsTitle.frame = CGRect(x: 20, y: 350, width: view.frame.width - 40, height: 30)

        // all products collection view
        allProductsCollectionView.backgroundColor = .systemBackground
        allProductsCollectionView.frame = CGRect(x: 20, y: 380, width: view.frame.width - 40, height: 300)
        allProductsCollectionView.delegate = self
        allProductsCollectionView.dataSource = self
    }

    //MARK: - Methods
    func getProducts() {
        provider.request(.getProducts) { result in
            switch result {
            case .success(let response):
                do {
                    let res = try JSONDecoder().decode([Product].self, from: response.data)
                    self.products = res
                    self.findPopularProducts()
                } catch {
                    print(error)
                }
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    self.allProductsCollectionView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    func findPopularProducts() {
        for product in products {
            if product.rating.count > 400{
                popularProducts.append(product)
            }
        }
        
    }

    // MARK: - Overrides
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 300)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionView {
            return popularProducts.count ?? .zero
        } else {
            return products.count ?? .zero
        }

    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ProductCustomCell
            cell.lbl.text = popularProducts[indexPath.row].title
            cell.bg.downloadImage(from: URL(string: popularProducts[indexPath.row].image))
            cell.price.text = String(popularProducts[indexPath.row].price) + " ₺"
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ProductCustomCell
            cell.lbl.text = products[indexPath.row].title
            return cell
        }
    }

}
