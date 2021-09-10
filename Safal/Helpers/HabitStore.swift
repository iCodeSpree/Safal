//
//  HabitStore.swift
//  Safal
//
//  Created by Shreya Jhala on 9/5/21.
//

import Foundation

class HabitStore {
    var items = [HabitsItem]()
    
    func add(_ item: HabitsItem, at index: Int, isDone: Bool = false) {
        items.insert(item, at: index)
    }
    
    @discardableResult func removeTask(at index: Int, isDone: Bool = false) -> HabitsItem {
        return items.remove(at: index)
    }
}
