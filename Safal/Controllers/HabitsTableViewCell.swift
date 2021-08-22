//
//  HabitsTableViewCell.swift
//  Safal
//
//  Created by Shreya Jhala on 8/22/21.
//

import UIKit

class HabitsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgToDo: UIImageView!
    @IBOutlet weak var lblHabit: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnCellTapped(_ sender: Any) {
        imgToDo.image = UIImage(named: "taskDoneIcon")
    }

}
