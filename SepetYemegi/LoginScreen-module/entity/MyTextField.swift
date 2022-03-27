//
//  MyTextField.swift
//  SepetYemegi
//
//  Created by Öznur Altıntaş on 25.03.2022.
//

import UIKit

class MyTextField: UITextField {

    override init(frame: CGRect){
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
     textFieldStyle()
    
    }
    
    
    private func textFieldStyle(){
        self.borderStyle = .none
        self.layer.cornerRadius = 20
        self.layer.borderColor =  UIColor(red: 209/255.0, green: 209/255.0, blue: 209/255.0, alpha: 1.0).cgColor
        self.layer.borderWidth = 1.5
        self.backgroundColor = UIColor.white
    }
}


