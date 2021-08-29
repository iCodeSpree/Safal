//
//  UIMethods.swift
//  Safal
//
//  Created by iCodeSpree on 7/31/21.
//

import UIKit

class UIExtentions {
    func btnDesign(_ btn: UIButton) {
        btn.layer.cornerRadius = btn.frame.height / 2
        btn.layer.borderWidth = 1
        btn.layer.borderColor = #colorLiteral(red: 1, green: 0.4766826034, blue: 0.2053719461, alpha: 1)
    }
    
    func txtFieldDesign(_ txt: UITextView) {
        txt.layer.cornerRadius = 10
        txt.layer.borderWidth = 1
        txt.layer.borderColor = #colorLiteral(red: 1, green: 0.4766826034, blue: 0.2053719461, alpha: 1)
    }
    
    func charcoalHex() -> UIColor {
        let color = UIColor(red: 29/255, green: 67/255, blue: 72/255, alpha: 1.0)
        return color
    }
}
