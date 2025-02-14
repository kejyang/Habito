//
//  HabitTaskManager.swift
//  Habito
//
//  Created by admin on 2/13/25.
//

import Foundation

class HabitTaskManager {
    
    func generateHabitDailyTasksByHabitId(id: Int) {
        let tasks = DBManager.dbhelper.fetchHabitDailyTaskByHabitId(id: id)
        
        let threeDaysAgo = Date(timeInterval: 259200, since: .now)
        
        for i in 0..<5 {
            let date = Date(timeInterval: 86400*Double(i), since: threeDaysAgo)
            
            let day = date.formatted(.dateTime.day())
            let month = date.formatted(.dateTime.month())
            let year = date.formatted(.dateTime.year())
            
            
        }
        
    }
    
}
