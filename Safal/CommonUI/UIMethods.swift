//
//  UIMethods.swift
//  Safal
//
//  Created by Shreya Jhala on 7/31/21.
//

import UIKit

class UIMethods {
    func btnDesign(_ btn: UIButton) {
        btn.layer.cornerRadius = btn.frame.height / 2
        btn.layer.borderWidth = 1
        btn.layer.borderColor = #colorLiteral(red: 1, green: 0.4766826034, blue: 0.2053719461, alpha: 1)
    }
}
