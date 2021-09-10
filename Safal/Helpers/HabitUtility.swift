//
//  HabitUtility.swift
//  Safal
//
//  Created by Shreya Jhala on 9/5/21.
//

import Foundation

class HabitUtility {
    
    private static let key = "tasks"
    
    // archive
    private static func archive(_ items: [HabitsItem]) -> NSData {
        return NSKeyedArchiver.archivedData(withRootObject: items) as NSData
    }
    
    // fetch
    static func fetch() -> [HabitsItem]? {
        guard let unarchivedData = UserDefaults.standard.object(forKey: key) as? Data else { return nil }
        
        return NSKeyedUnarchiver.unarchiveObject(with: unarchivedData) as? [HabitsItem]
    }
    
    // save
    static func save(_ items: [HabitsItem]) {
        
        // archive
        let archivedItems = archive(items)
        
        // set object for key
        UserDefaults.standard.set(archivedItems, forKey: key)
        UserDefaults.standard.synchronize()
    }
}
