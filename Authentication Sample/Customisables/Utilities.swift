//
//  Utilities.swift
//  Authentication Sample
//
//  Created by Robert O'Brien on 16/07/2020.
//  Copyright © 2020 Robert O'Brien. All rights reserved.
//

import Foundation
import UIKit

class Utilities {
    
    static func styleTextField(_ textField:UITextField){
        
        //initialises the bottom line
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y:textField.frame.height - 2, width: textField.frame.width, height: 2)
        
        //setting the color of the line and the opacity
        bottomLine.backgroundColor = UIColor.init(red: 255/255, green: 0/255, blue: 0/255, alpha: 1).cgColor
        
        //removing the textfield borders
        textField.borderStyle = .none
        
        // Adding line to eaxh textfieeld
        textField.layer.addSublayer(bottomLine)
        
    }
    
    static func styleFilledButton(_ filledButton:UIButton){
        filledButton.layer.cornerRadius = 25.0
        filledButton.tintColor = UIColor.white
        
        
    }
    
    

    
    
}

