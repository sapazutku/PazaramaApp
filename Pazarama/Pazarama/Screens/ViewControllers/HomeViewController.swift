//
//  ViewController.swift
//  Pazarama
//
//  Created by utku on 25.10.2022.
//

import UIKit
import Moya

struct CustomData {
    var title: String
    var url: String
    var backgroundImage: UIImage
}

class HomeViewController: UIViewController, UICollectionViewDelegate {
    
    fileprivate let data = [
        CustomData(title: "The Islands!", url: "maxcodes.io/enroll", backgroundImage: #imageLiteral(resourceName: "islandZero")),
        CustomData(title: "Subscribe to maxcodes boiiii!", url: "maxcodes.io/courses", backgroundImage: #imageLiteral(resourceName: "islandThree")),
        CustomData(title: "StoreKit Course!", url: "maxcodes.io/courses", backgroundImage: #imageLiteral(resourceName: "islandZero")),
        CustomData(title: "Collection Views!", url: "maxcodes.io/courses", backgroundImage: #imageLiteral(resourceName: "islandZero")),
        CustomData(title: "MapKit!", url: "maxcodes.io/courses", backgroundImage: #imageLiteral(resourceName: "islandOne")),
    ]
    
    
    //MARK: - Properties
    let provider = MoyaProvider<ProductsAPI>()

    var products = [Product]()
    var popularProducts = [Product]()
    
    fileprivate let collectionView:UICollectionView = {
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
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        getProducts()
        configureUI()
    }

    func configureUI() {
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: view.frame.width/2).isActive = true
    }

    //MARK: - Methods
    func getProducts() {
        provider.request(.getProducts) { result in
            switch result {
            case .success(let response):
                do {
                    let products = try JSONDecoder().decode([Product].self, from: response.data)
                    self.products = products
                } catch {
                    print(error)
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
}

extension HomeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2.5, height: collectionView.frame.width/2)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count ?? .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ProductCustomCell
        cell.data = self.data[indexPath.item]
        return cell
    }
}


