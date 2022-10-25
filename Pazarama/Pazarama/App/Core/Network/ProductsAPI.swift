//
//  ProductsAPI.swift
//  Pazarama
//
//  Created by utku on 25.10.2022.
//

import Foundation
import Moya 

enum ProductsAPI {
    case getProducts
    case getCategoryProducts(category: String)
}
extension ProductsAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://fakestoreapi.com")!
    }
    var path: String {
        switch self {
        case .getProducts:
            return "/products"
        case .getCategoryProducts(let category):
            return "/products/category/\(category)"
        }
    }
    var method: Moya.Method {
        switch self {
        case .getProducts, .getCategoryProducts:
            return .get
        }
    }
    var task: Task {
        switch self {
        case .getProducts:
            return .requestPlain
        case .getCategoryProducts:
            return .requestPlain
        }
    }
    var headers: [String : String]? {
        return nil
    }
 }
