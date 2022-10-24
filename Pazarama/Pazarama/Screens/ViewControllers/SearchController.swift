//
//  SearchController.swift
//  Pazarama
//
//  Created by utku on 25.10.2022.
//

import UIKit

class SearchController: UIViewController {


    // title 
    private let titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Search"
        lbl.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        lbl.textColor = .white
        lbl.textAlignment = .center
        return lbl
    }()



    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemIndigo
        view.addSubview(titleLbl)
        titleLbl.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        titleLbl.center = view.center

    }

   
}
