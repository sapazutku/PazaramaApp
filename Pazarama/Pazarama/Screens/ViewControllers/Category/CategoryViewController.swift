//
//  SearchController.swift
//  Pazarama
//
//  Created by utku on 25.10.2022.
//

import UIKit

class ResultVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
}

class CategoryViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchResultsUpdating, UISearchBarDelegate {

    // MARK: - Properties

    let searchController = UISearchController()
    var filteredArray = [CategoryModal]()

    private let categoryList: [CategoryModal] = [
        CategoryModal(name: "electronics", image: "electronics"),
        CategoryModal(name: "jewelery", image: "jewelery"),
        CategoryModal(name: "women's clothing", image: "womens"),
        CategoryModal(name: "men's clothing", image: "mens"),
    ]

    // MARK: - UI Elements

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize.width = UIScreen.main.bounds.width / 2.5
        layout.itemSize.height = UIScreen.main.bounds.width / 2.5
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
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemBackground
        self.navigationItem.standardAppearance = appearance
        self.navigationItem.scrollEdgeAppearance = appearance
    }

    // MARK: - Helpers

    func configureUI() {
        //view.backgroundColor = .white
        navigationItem.title = "Categories"

        // collection
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: "Category")
        view.addSubview(collectionView)
        collectionView.frame = view.frame

        // search controller
        searchController.searchBar.placeholder = "Search"

        
    }


    // MARK: - Overrides
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            if searchController.isActive && searchController.searchBar.text != "" {
                return filteredArray.count ?? .zero
            }
            else {
                return categoryList.count ?? .zero
            }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Category", for: indexPath) as! CategoryCollectionViewCell
        if searchController.isActive && searchController.searchBar.text != "" {
            cell.categoryImage.image = UIImage(named: filteredArray[indexPath.row].image)
        } else {
            cell.categoryImage.image = UIImage(named: categoryList[indexPath.row].image)
        }
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ProductListViewController()
        if searchController.isActive && searchController.searchBar.text != "" {
            vc.category = filteredArray[indexPath.row].name
        } else {
            vc.category = categoryList[indexPath.row].name
        }
        navigationController?.pushViewController(vc, animated: true)
    }

    


    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        let filtered = categoryList.filter { $0.name.lowercased().contains(text.lowercased()) }
        filteredArray = filtered
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
        print(filtered)
    }




}

