//
//  HabitsViewController.swift
//  Safal
//
//  Created by iCodeSpree on 8/22/21.
//

import UIKit

class HabitsViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tblView: UITableView!
    
    private var cellArr = [HabitsItem]()
    private var selectedData = [NSMutableDictionary]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblView.delegate = self
        tblView.dataSource = self
        
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
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
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
    
    @objc func seletedBtn(_ sender: UITapGestureRecognizer) {
        
    }
}

extension HabitsViewController {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HabitsTableViewCell", for: indexPath) as! HabitsTableViewCell
        if indexPath.row < cellArr.count {
            let item = cellArr[indexPath.row]
            cell.lblHabit.text = item.title
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tblView.deselectRow(at: indexPath, animated: true)
        if indexPath.row < cellArr.count {
            let item = cellArr[indexPath.row]
            item.done = #imageLiteral(resourceName: "taskDoneIcon")
            tblView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if indexPath.row < cellArr.count {
            cellArr.remove(at: indexPath.row)
            tblView.deleteRows(at: [indexPath], with: .top)
        }
    }
    
}
