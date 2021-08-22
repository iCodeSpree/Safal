//
//  ViewController.swift
//  Safal
//
//  Created by iCodeSpree on 7/31/21.
//

import UIKit
import Firebase

class ViewController: BaseViewController {
    
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnLoginEmail: UIButton!
    @IBOutlet weak var btnSignUp: UIButton!
    
    let commonUI = UIExtentions()
    var loginState: AuthStateDidChangeListenerHandle?
    var rootVC: UINavigationController!
    
    override func viewWillAppear(_ animated: Bool) {
        loginState = Auth.auth().addStateDidChangeListener { auth, user in
            if self.isUserSignedIn() {
                self.present(identifier: "HomeViewController")
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        Auth.auth().removeStateDidChangeListener(loginState!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonUI.btnDesign(btnLoginEmail)
        commonUI.btnDesign(btnSignUp)
    }

    @IBAction func btnLoginEmailTapped(_ sender: Any) {
        registerUser()
    }
    
    @IBAction func btnSignUpTapped(_ sender: Any) {
        self.present(identifier: "SignUpViewController")
    }
    
    func registerUser() {
        guard let email = txtUsername.text, let password = txtPassword.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let _ = self, error != nil else { return }
            self!.present(identifier: "SelectHabitsViewController")
        }
    }
    
    func isUserSignedIn() -> Bool {
        return Auth.auth().currentUser != nil
    }
    
}
