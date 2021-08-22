//
//  HomeViewController.swift
//  Safal
//
//  Created by iCodeSpree on 7/31/21.
//

import UIKit
import Firebase

class HomeViewController: BaseViewController {
    
    @IBOutlet weak var segmentTab: UISegmentedControl!
    @IBOutlet weak var btnSignOut: UIButton!
    @IBOutlet weak var segmentView: UIView!
    @IBOutlet weak var viewOne: UIView!
    @IBOutlet weak var viewTwo: UIView!
    
    let uiExensions = UIExtentions()

    override func viewDidLoad() {
        super.viewDidLoad()
        uiExensions.btnDesign(btnSignOut)
        segmentTab.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: uiExensions.charcoalHex()], for: .normal)
    }
    
    @IBAction func btnSignOutTapped(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            present(identifier: "ViewController")
        } catch {
            print("Unable to sign out")
        }
    }
    
    @IBAction func segmentSelection(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            viewOne.alpha = 1
            viewTwo.alpha = 0
        } else if sender.selectedSegmentIndex == 1 {
            viewOne.alpha = 0
            viewTwo.alpha = 1
        }
    }
    
}

