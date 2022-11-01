//
//  HomeViewModal.swift
//  Pazarama
//
//  Created by utku on 1.11.2022.
//

import Foundation
import Moya

enum ProductChanges {
    case getBestSellerProducts
    case getAllProducts
}

class HomeViewModal{
    //MARK: - Properties
    let provider = MoyaProvider<ProductsAPI>()
    var products = [Product](){
        didSet{
            self.changeHandler?(.getAllProducts)
        }
    }
    var popularProducts = [Product](){
        didSet{
            self.changeHandler?(.getBestSellerProducts)
        }
    }
    
    var changeHandler: ((ProductChanges) -> Void)?
    
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
