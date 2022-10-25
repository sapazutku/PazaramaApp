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

    private let topTitle : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Best Seller Products"
        lbl.font = UIFont(name: "HelveticaNeue-Bold", size: 30)
        lbl.textColor = .black
        return lbl
    }()


    //MARK: - Lifecycle
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        var appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        self.navigationItem.standardAppearance = appearance
        self.navigationItem.scrollEdgeAppearance = appearance
        view.backgroundColor = .systemBackground
        getProducts()
        
    }

    override func viewWillAppear (_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.addSubview(collectionView)
        view.addSubview(topTitle)
        configureUI()
    }

    func configureUI() {
        collectionView.backgroundColor = .white
        
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 300).isActive = true

        collectionView.delegate = self
        collectionView.dataSource = self

        topTitle.frame = CGRect(x: 100, y: 100, width: 200, height: 20)

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
        return popularProducts.count ?? .zero

    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ProductCustomCell
        cell.lbl.text = popularProducts[indexPath.row].title
        cell.bg.downloadImage(from: URL(string: popularProducts[indexPath.row].image))
        cell.price.text = String(popularProducts[indexPath.row].price) + " ₺"
        return cell
    }

}
