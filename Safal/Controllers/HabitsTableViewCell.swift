//
//  HabitsTableViewCell.swift
//  Safal
//
//  Created by iCodeSpree on 8/22/21.
//

import UIKit

protocol TaskDone {
    func markDone(state: Bool, index: Int?)
}

class HabitsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblHabit: UILabel!
    @IBOutlet weak var btnTaskDone: UIButton!
    
    var habit: [HabitsItem]?
    var delegate: TaskDone?
    var didTap: Bool = false
    var index: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func btnTaskDoneTapped(_ sender: Any) {
        if habit![index!].done {
            delegate?.markDone(state: false, index: index)
        } else {
            delegate?.markDone(state: true, index: index)
        }
        
        /* if didTap {
         didTap = false
         btnTaskDone.setImage(UIImage(named: "taskToBeDoneIcon.png"), for: .normal)
     } else {
         didTap = true
         btnTaskDone.setImage(UIImage(named: "taskDoneIcon.png"), for: .normal)
     } */
        
    }
    
}
