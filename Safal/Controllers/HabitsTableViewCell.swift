//
//  HabitsTableViewCell.swift
//  Safal
//
//  Created by iCodeSpree on 8/22/21.
//

import UIKit

class HabitsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblHabit: UILabel!
    @IBOutlet weak var btnTaskDone: UIButton!
    
    var didTap: Bool = false

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func btnTaskDoneTapped(_ sender: Any) {
        if didTap {
            didTap = false
            btnTaskDone.setImage(UIImage(named: "taskToBeDoneIcon.png"), for: .normal)
        } else {
            didTap = true
            btnTaskDone.setImage(UIImage(named: "taskDoneIcon.png"), for: .normal)
        }
    }
    
}
