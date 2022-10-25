//
//  SearchController.swift
//  Pazarama
//
//  Created by utku on 25.10.2022.
//

import UIKit

class CategoryViewController: UIViewController,  UICollectionViewDataSource, UICollectionViewDelegate {

    // MARK: - Properties

    
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryList.count ?? .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Category", for: indexPath) as! CategoryCollectionViewCell
        
        cell.categoryTitle.text = categoryList[indexPath.row]
        
        
        return cell
    }

    private let categoryList: [String] = [
        "Electronics",
        "Jewelery",
        "Women's Clothing",
        "Men's Clothing"
    ]

       private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize.width = UIScreen.main.bounds.width
        // add border to the cell
        layout.itemSize.height = UIScreen.main.bounds.width + 150
        // change layout background color
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    // MARK: - Helpers

    func configureUI() {
        view.backgroundColor = .white
        navigationItem.title = "Categories"
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: "Category")
        view.addSubview(collectionView)
        collectionView.frame = view.frame
        
    }

    



}

