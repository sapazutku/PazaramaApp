//
//  CustomInput.swift
//  Pazarama
//
//  Created by utku on 30.10.2022.
//

import UIKit

class CustomInput: UITextField {

    let loginVC = LoginViewController()
    
    init(placeholder: String, isSecure: Bool , keyboardType: UIKeyboardType, method: Selector) {
        super.init(frame: .zero)
        self.placeholder = placeholder
        self.isSecureTextEntry = isSecure
        self.keyboardType = keyboardType
        self.addTarget(self, action: method, for: .editingChanged)
        self.backgroundColor = .secondarySystemBackground
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.borderStyle = .roundedRect
        self.autocorrectionType = .no
        self.autocapitalizationType = .none
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        self.leftViewMode = .always
        self.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    

}
