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

        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        getProducts()
        
    }


    override func viewWillAppear (_ animated: Bool) {
        super.viewWillAppear(animated)
        let scrollView = UIScrollView(frame: CGRect(x: 10, y: 10, width: view.frame.size.width, height: view.frame.size.height))
        scrollView.contentSize = CGSize(width: view.frame.size.width, height: view.frame.size.height + 200)
        view.addSubview(scrollView)

        scrollView.addSubview(collectionView)
        scrollView.addSubview(topTitle)
        scrollView.addSubview(allProductsTitle)
        scrollView.addSubview(allProductsCollectionView)
        configureUI()
    }

    func configureUI() {
        // scroll view

        // best seller title
        topTitle.frame = CGRect(x: 20, y: 50, width: view.frame.width - 40, height: 30)

        // collection view
        collectionView.backgroundColor = .systemBackground
        collectionView.frame = CGRect(x: 20, y: 50, width: view.frame.width - 40, height: 400)
        collectionView.delegate = self
        collectionView.dataSource = self

        // all products title
        allProductsTitle.frame = CGRect(x: 20, y: 480, width: view.frame.width - 40, height: 30)

        // all products collection view
        allProductsCollectionView.backgroundColor = .systemBackground
        allProductsCollectionView.frame = CGRect(x: 20, y: 530, width: view.frame.width - 40, height: 400)
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
        return CGSize(width: 150, height: 340)
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
            cell.product = popularProducts[indexPath.row]
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ProductCustomCell
            cell.product = products[indexPath.row]
            return cell
        }
    }

}
