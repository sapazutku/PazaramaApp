//
//  ShoppingChartViewController.swift
//  Pazarama
//
//  Created by utku on 25.10.2022.
//

import UIKit

class ShoppingChartViewController: UIViewController {

    // title 
    private let titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Chart"
        lbl.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        lbl.textColor = .white
        lbl.textAlignment = .center
       
        return lbl
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemIndigo
        titleLbl.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        view.addSubview(titleLbl)
        titleLbl.center = view.center
    }
}


