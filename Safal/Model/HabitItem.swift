//
//  HabitItem.swift
//  Safal
//
//  Created by iCodeSpree on 8/27/21.
//

import UIKit

class HabitsItem: NSObject, NSCoding {
    
    var title: String = ""
    var done: Bool = false
    
    public init(title: String) {
        self.title = title
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(self.title, forKey: "title")
        coder.encode(self.done, forKey: "done")
    }
    
    required init?(coder: NSCoder) {
        if let title = coder.decodeObject(forKey: "title") as? String {
            self.title = title
        } else {
            return nil
        }
        
        if coder.containsValue(forKey: "done") {
            //self.done = coder.decodeObject(forKey: "done")
        } else {
            return nil
        }
    }
}

extension HabitsItem {
    public func getMockData() -> [HabitsItem] {
        return [
            HabitsItem(title: "Wake up at 5am"),
            HabitsItem(title: "Exercise"),
            HabitsItem(title: "Meditate"),
            HabitsItem(title: "Journal"),
            HabitsItem(title: "Eat greens")
        ]
    }
}

extension Collection where Iterator.Element == HabitsItem {
    
    private static func persistencePath() -> URL? {
        let url = try? FileManager.default.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        return url?.appendingPathComponent("habitsitems.bin")
    }
    
    func writeToPersistance() throws {
        if let url = Self.persistencePath(), let array = self as? NSArray {
            let data = try? NSKeyedArchiver.archivedData(withRootObject: array, requiringSecureCoding: true)
            try data?.write(to: url)
        } else {
            throw NSError(domain: "com.example.Safal", code: 10, userInfo: nil)
        }
    }
    
    static func readFromPersistence() throws -> [HabitsItem] {
        if let url = persistencePath(), let data = (try Data(contentsOf: url) as Data?) {
            if let array = NSKeyedUnarchiver.unarchiveObject(with: data) as? [HabitsItem] {
                return array
            } else {
                throw NSError(domain: "com.example.Safal", code: 11, userInfo: nil)
            }
        } else {
            throw NSError(domain: "com.example.Safal", code: 12, userInfo: nil)
        }
    }
}
