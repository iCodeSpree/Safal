//
//  StreakViewController.swift
//  Safal
//
//  Created by iCodeSpree on 9/6/21.
//

import UIKit

class StreakViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var lblMonth: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var selectedDate = Date()
    var totalSquares = [String]()
    let calendar = CalenderHelper()
    
    override func viewDidLoad() {
        setStreakCellView()
        setMonthView()
    }
    
    func setStreakCellView() {
        let width = (collectionView.frame.size.width - 2) / 8
        let height = (collectionView.frame.size.height - 2) / 8
        
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.itemSize = CGSize(width: width, height: height)
    }
    
    func setMonthView() {
        totalSquares.removeAll()
        let daysInMonth = calendar.daysInMonth(selectedDate)
        let firstDayOfMonth = calendar.firstOfMonth(selectedDate)
        let startingSpaces = calendar.weekDay(firstDayOfMonth)
        var count = 2
        
        while count <= 42 {
            if (count <= startingSpaces || count - startingSpaces > daysInMonth) {
                totalSquares.append("")
            } else {
                totalSquares.append(String(count - startingSpaces))
            }
            count += 1
        }
        lblMonth.text = calendar.monthString(selectedDate) + " " + calendar.yearString(selectedDate)
        collectionView.reloadData()
    }
    
    @IBAction func btnLeftTapped(_ sender: Any) {
        selectedDate = calendar.subtractMonth(selectedDate)
        setMonthView()
    }
    
    @IBAction func btnRightTapped(_ sender: Any) {
        selectedDate = calendar.addMonth(selectedDate)
        setMonthView()
    }
    
}

extension StreakViewController {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return totalSquares.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StreakCollectionViewCell", for: indexPath) as! StreakCollectionViewCell
        cell.btnDayOfMonth.setTitle(totalSquares[indexPath.item], for: .normal)
        cell.btnDayOfMonth.isEnabled = true
        return cell
    }
}
