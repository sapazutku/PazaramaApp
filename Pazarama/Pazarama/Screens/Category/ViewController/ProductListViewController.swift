//
//  ProductListView.swift
//  Pazarama
//
//  Created by utku on 29.10.2022.
//

import UIKit
import Moya

class ProductListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    
    
    //MARK: - Properties
    let provider = MoyaProvider<ProductsAPI>()

    var products = [Product]()

    var category: String = ""
    

    // MARK: - UI Elements
    private let collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
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
        configureUI()
    }

    func configureUI() {
        // scroll view
        // collection view
        collectionView.backgroundColor = .systemBackground
        collectionView.frame = CGRect(x: 10, y: 50, width: view.frame.width - 40, height: view.frame.height - 100)
        collectionView.delegate = self
        collectionView.dataSource = self
    }

     



    //MARK: - Methods
    func getProducts() {
        provider.request(.getCategoryProducts(category: category)) { result in
            switch result {
            case .success(let response):
                do {
                    let products = try JSONDecoder().decode([Product].self, from: response.data)
                    self.products = products
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                } catch let error {
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    // MARK: - Overrides
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width / 2.5 , height: view.frame.height / 2.5 )
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count ?? .zero
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ProductCustomCell
        cell.product = products[indexPath.row]
        return cell
    }

}

