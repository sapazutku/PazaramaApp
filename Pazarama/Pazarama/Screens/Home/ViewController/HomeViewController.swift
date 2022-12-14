//
//  ViewController.swift
//  Pazarama
//
//  Created by utku on 25.10.2022.
//

import UIKit
import Moya

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    let homeViewModal = HomeViewModal()
    
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
        /**
         // navigation bar
         navigationController?.navigationBar.isTranslucent = false
         navigationController?.navigationBar.backgroundColor = .systemBackground
         let appearance = UINavigationBarAppearance()
         appearance.configureWithOpaqueBackground()
         appearance.backgroundColor = .systemBackground
         self.navigationItem.standardAppearance = appearance
         self.navigationItem.scrollEdgeAppearance = appearance
         self.navigationItem.compactAppearance = appearance
         */
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemBackground
        self.navigationItem.standardAppearance = appearance
        self.navigationItem.scrollEdgeAppearance = appearance
        self.navigationItem.compactAppearance = appearance
        
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        homeViewModal.getProducts()
        homeViewModal.changeHandler = { change in
            self.collectionView.reloadData()
            self.allProductsCollectionView.reloadData()
        }

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
    
    // tabbar getting lost problem:
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tabBarController?.tabBar.isHidden = false
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
        allProductsTitle.frame = CGRect(x: 5, y: 480, width: view.frame.width - 40, height: 30)

        // all products collection view
        allProductsCollectionView.backgroundColor = .systemBackground
        allProductsCollectionView.frame = CGRect(x: 20, y: 510, width: view.frame.width - 40, height: 400)
        allProductsCollectionView.delegate = self
        allProductsCollectionView.dataSource = self
    }
    
    func reloadCollectionData(){
        collectionView.reloadData()
        allProductsCollectionView.reloadData()
    }

     
    // MARK: - Overrides
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 340)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionView {
            return homeViewModal.popularProducts.count ?? .zero
        } else {
            return homeViewModal.products.count ?? .zero
        }
    }

    // select item
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailViewController()
        if collectionView == self.collectionView {
            vc.product = homeViewModal.popularProducts[indexPath.row]
        } else {
            vc.product = homeViewModal.products[indexPath.row]
        }
        navigationController?.pushViewController(vc, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ProductCustomCell
            cell.product = homeViewModal.popularProducts[indexPath.row]
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ProductCustomCell
            cell.product = homeViewModal.products[indexPath.row]
            return cell
        }
    }



}
