//
//  TabBarController.swift
//  Pazarama
//
//  Created by utku on 25.10.2022.
//

import UIKit

class TabBarController : UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
        
        tabBar.tintColor = .systemPink
        tabBar.backgroundColor = .systemBackground
        
        // View Controllers
                viewControllers = [
                    createTabBarItem(tabBarTitle: "Home", tabBarImage: "house", viewController: HomeViewController()),
                    createTabBarItem(tabBarTitle: "Category", tabBarImage: "square.stack.3d.up"  , viewController: CategoryViewController()),
                    createTabBarItem(tabBarTitle: "Shopping Chart", tabBarImage: "cart", viewController: ShoppingCartViewController()),
                    createTabBarItem(tabBarTitle: "Profile", tabBarImage: "person", viewController: ProfileViewController())

                    
                ]
            }
            func createTabBarItem(tabBarTitle: String, tabBarImage: String, viewController: UIViewController) -> UINavigationController {
                let navCont = UINavigationController(rootViewController: viewController)
                navCont.tabBarItem.title = tabBarTitle
                
                navCont.tabBarItem.image = UIImage(systemName: tabBarImage)
                
                // Nav Bar Customisation
                
                navCont.navigationBar.isTranslucent = true
                
                // Nav Bar Title Customisation
                
                navCont.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 20)!, NSAttributedString.Key.foregroundColor: UIColor.black]
                
                return navCont
        }
}

