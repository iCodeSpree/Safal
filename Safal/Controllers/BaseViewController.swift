//
//  BaseViewController.swift
//  Safal
//
//  Created by Shreya Jhala on 7/31/21.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func present(identifier: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: identifier) as! BaseViewController
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true, completion: nil)
    }

}

