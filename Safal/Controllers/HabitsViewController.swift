//
//  HabitsViewController.swift
//  Safal
//
//  Created by iCodeSpree on 8/22/21.
//

import UIKit

class HabitsViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate, TaskDone {
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var lblPercentage: UILabel!
    @IBOutlet weak var progView: UIProgressView!
    @IBOutlet weak var btnAddTask: UIButton!
    
    var cellArr = [HabitsItem]()
    var habitStore: HabitStore! {
        didSet {
            habitStore.items = HabitUtility.fetch() ?? [HabitsItem]()
            tblView.reloadData()
        }
    }
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        progView.progress = 0
        
        tblView.delegate = self
        tblView.dataSource = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidEnterBackground(_:)), name: UIApplication.didEnterBackgroundNotification, object: nil)
        
        do {
            self.cellArr = try [HabitsItem].readFromPersistence()
        } catch let error as NSError {
            if error.domain == NSCocoaErrorDomain && error.code == NSFileReadNoSuchFileError {
                NSLog("No persistence found...")
            } else {
                let alert = self.presentAlertViewController(title: "Error", message: "Could not load your list of habits :(")
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion:  nil)
                NSLog("Error loading from persistence")
            }
        }
    }
    
    @objc public func applicationDidEnterBackground(_ notification: NSNotification) {
        do {
            try cellArr.writeToPersistance()
        } catch {
            NSLog("Error writing to persistence")
        }
    }
    
    @IBAction func btnAddTaskTapped(_ sender: Any) {
        let alert = self.presentAlertViewController(title: "What would you like to work on today?", message: "Consistency beats talent!")
        alert.addTextField(configurationHandler: nil)
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { _ in
            if let title = alert.textFields?[0].text, title.count > 0 {
                self.addNewHabit(title: title)
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func addNewHabit(title: String) {
        let index = cellArr.count
        cellArr.append(HabitsItem(title: title))
        tblView.insertRows(at: [IndexPath(row: index, section: 0)], with: .top)
    }
    
    func markDone(state: Bool, index: Int?) {
        cellArr[index!].done = state
        tblView.reloadRows(at: [IndexPath(row: index!, section: 0)], with: UITableView.RowAnimation.none)
    }
}

extension HabitsViewController {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellArr.count
        //return habitStore.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HabitsTableViewCell", for: indexPath) as! HabitsTableViewCell
        if indexPath.row < cellArr.count {
            let item = cellArr[indexPath.row]
            let cellCount = Float(cellArr.count)
            let countUnit = Float(1/cellCount)
            let progValue = countUnit >= 0.1 ? countUnit : 0
            
            btnAddTask.isEnabled = cellCount == 10 ? false : true
            
            cell.delegate = self
            cell.habit = cellArr
            cell.index = indexPath.row
            
            do {
                try cellArr.writeToPersistance()
            } catch {
                NSLog("Error writing to persistence")
            }
            
            cell.lblHabit.text = item.title
            if cellArr[indexPath.row].done {
                cell.btnTaskDone.setImage(UIImage(named: "taskDoneIcon.png"), for: .normal)
                progView.progress += Float(progValue)
                if progView.progress == 1.0 {
                    lblPercentage.text = "100%"
                    let alert = self.presentAlertViewController(title: "Yayyy!", message: "You did it.")
                    self.present(alert, animated: true) {
                        do {
                            sleep(1)
                        }
                    }
                    self.dismiss(animated: true, completion: nil)
                } else {
                    lblPercentage.text = "\(round(progView.progress * 100))%"
                }
            } else {
                cell.btnTaskDone.setImage(UIImage(named: "taskToBeDoneIcon.png"), for: .normal)
                progView.progress -= Float(progValue)
                lblPercentage.text = progView.progress == 0 ? "0%" : "\(round(progView.progress * 100))%"
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tblView.deselectRow(at: indexPath, animated: false)
        if indexPath.row < cellArr.count {
            tblView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if indexPath.row < cellArr.count {
            cellArr.remove(at: indexPath.row)
            tblView.deleteRows(at: [indexPath], with: .top)
            btnAddTask.isEnabled = cellArr.count == 10 ? false : true
        }
    }
    
}
