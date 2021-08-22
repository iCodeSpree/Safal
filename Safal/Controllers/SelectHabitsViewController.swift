//
//  SelectHabitsViewController.swift
//  Safal
//
//  Created by iCodeSpree on 7/31/21.
//

import UIKit

class SelectHabitsViewController: BaseViewController {
    
    @IBOutlet weak var txtHabitOne: UITextView!
    @IBOutlet weak var txtHabitTwo: UITextView!
    @IBOutlet weak var txtHabitThree: UITextView!
    @IBOutlet weak var btnNext: UIButton!
    
    let uiExtensions = UIExtentions()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiExtensions.txtFieldDesign(txtHabitOne)
        uiExtensions.txtFieldDesign(txtHabitTwo)
        uiExtensions.txtFieldDesign(txtHabitThree)
        uiExtensions.btnDesign(btnNext)
    }
    
    @IBAction func btnNextTapped(_ sender: Any) {
        self.present(identifier: "HomeViewController")
    }
}
