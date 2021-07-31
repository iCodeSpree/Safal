//
//  SignUpViewController.swift
//  Safal
//
//  Created by Shreya Jhala on 7/31/21.
//

import UIKit
import Firebase

class SignUpViewController: BaseViewController {
    
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var lblError: UILabel!
    
    let commonUI = UIMethods()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonUI.btnDesign(btnSignUp)
        lblError.isHidden = true
    }
    
    @IBAction func btnSignUpTapped(_ sender: Any) {
        Auth.auth().createUser(withEmail: txtUsername.text!, password: txtPassword.text!) { result, error in
            guard let user = result?.user else { return }
            if let _ = error {
                self.lblError.isHidden = false
                self.lblError.text = "Please enter correct email id!"
            }
            print("\(user.isEmailVerified) created")
            self.navigationController?.popViewController(animated: true)
        }
    }
}
