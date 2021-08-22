//
//  HabitsViewController.swift
//  Safal
//
//  Created by iCodeSpree on 8/22/21.
//

import UIKit

class HabitsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tblViewHabits: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblViewHabits.delegate = self
        tblViewHabits.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HabitsTableViewCell", for: indexPath) as? HabitsTableViewCell else {
            fatalError()
        }
        return cell
    }

}
