//
//  SearchController.swift
//  Pazarama
//
//  Created by utku on 25.10.2022.
//

import UIKit

class CategoryViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    // MARK: - Properties

    private let categoryList: [CategoryModal] = [
        CategoryModal(name: "Electronics", image: "electronics"),
        CategoryModal(name: "Jewelery", image: "jewelery"),
        CategoryModal(name: "Women", image: "womens"),
        CategoryModal(name: "Men", image: "mens"),
        
    ]

       private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize.width = UIScreen.main.bounds.width / 2.5
        layout.itemSize.height = UIScreen.main.bounds.height / 2.5 - 30
        layout.scrollDirection = .vertical
        
        layout.sectionInset = UIEdgeInsets(top: 30, left: 30, bottom: 0, right: 30)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        return cv
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        view.backgroundColor = .white
        
    }

    // MARK: - Helpers

    func configureUI() {
        //view.backgroundColor = .white
        navigationItem.title = "Categories"
       
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: "Category")
        view.addSubview(collectionView)
        collectionView.frame = view.frame 
        
    }


    // MARK: - Overrides
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryList.count ?? .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Category", for: indexPath) as! CategoryCollectionViewCell
        
        cell.categoryTitle.text = categoryList[indexPath.row].name
        cell.categoryImage.image = UIImage(named: categoryList[indexPath.row].image)
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(categoryList[indexPath.row].name)        
    }

    



}

