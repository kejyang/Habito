//
//  HabitCompletionTable.swift
//  Habito
//
//  Created by Kenneth Yang on 2/13/25.
//

import Foundation
import SQLite3
extension DBManager{
    func createHabitDailyTaskTable() {
        let sql = "create table if not exists habit_daily_tasks(id integer primary key autoincrement, day text, month text, year text, completion_value integer, completed integer, FOREIGN KEY (habit_id) REFERENCES habits(id))"
        if sqlite3_exec(db,sql,nil,nil,nil) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("there is an error \(err)")
        }
    }
    
    func insertHabitDailyTask(day: String, month: String, year: String, completionValue: Int, completed: Bool, habitId: Int) {
        var completedInt32 : Int32 = 0
        if completed == true{
            completedInt32 = 1
        }
        var stmt: OpaquePointer?
        let dayNSString = day as NSString
        let monthDetailsNSString = month as NSString
        let yearNSString = year as NSString
        let completionValueInt32 = Int32(completionValue)
        let habitIdValueInt32 = Int32(habitId)
        
        let query = "INSERT INTO habit_daily_tasks(day, month, year, completionValue, completed, habit_id) VALUES (?, ?, ?, ?, ?, ?)"
        
        // Prepare the statement
        if sqlite3_prepare_v2(db, query, -1, &stmt, nil) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("There is an error in preparing the query: \(err)")
            return
        }
        
        // Bind parameters
        if sqlite3_bind_text(stmt, 1, dayNSString.utf8String, -1, nil) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("There is an error binding day: \(err)")
            return
        }
        
        if sqlite3_bind_text(stmt, 2, monthDetailsNSString.utf8String, -1, nil) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("There is an error binding month: \(err)")
            return
        }
        
        if sqlite3_bind_text(stmt, 3, yearNSString.utf8String, -1, nil) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("There is an error binding year: \(err)")
            return
        }
        
        if sqlite3_bind_int(stmt, 4, completionValueInt32) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("There is an error binding completionValue: \(err)")
            return
        }
        
        if sqlite3_bind_int(stmt, 5, completedInt32) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("There is an error binding completed: \(err)")
            return
        }
        
        if sqlite3_bind_int(stmt, 6, habitIdValueInt32) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("There is an error binding habit_id: \(err)")
            return
        }
        
        // Execute the query
        if sqlite3_step(stmt) != SQLITE_DONE {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("There is an error in inserting data: \(err)")
        } else {
            print("Data inserted successfully into habits daily task table")
        }
        
        // Finalize the statement
        if sqlite3_finalize(stmt) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("Error finalizing insert statement: \(err)")
        }
    }
    
    func fetchHabitDailyTasks() -> [HabitDailyTaskModel] {
        var stmt: OpaquePointer?
        var habitDailyTaskList = [HabitDailyTaskModel]()
        let query = "SELECT * FROM habit_daily_tasks"
        
        if sqlite3_prepare_v2(db, query, -1, &stmt, nil) != SQLITE_OK {
            print("Error preparing fetch query: \(String(cString: sqlite3_errmsg(db)!))")
            return habitDailyTaskList
        }
        
        while sqlite3_step(stmt) == SQLITE_ROW {
            let id = sqlite3_column_int(stmt, 0)
            let day = String(cString: sqlite3_column_text(stmt, 1))
            let month = String(cString: sqlite3_column_text(stmt, 2))
            let year = String(cString: sqlite3_column_text(stmt, 3))
            let completionValue = sqlite3_column_int(stmt, 4)
            let completed = sqlite3_column_int(stmt, 5)
            let habitId = sqlite3_column_int(stmt, 6)
            let habitDailyTaskModel = HabitDailyTaskModel(id: Int(id), day: day, month: month, year: year, completionValue: Int(completionValue), completed: (Int(completed) != 0), habitId: Int(habitId))
            habitDailyTaskList.append(habitDailyTaskModel)
        }
        if sqlite3_finalize(stmt) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("Error finalizing fetch query: \(err)")
        }
        return habitDailyTaskList
    }
    
    func fetchHabitDailyTaskById(id: Int) -> HabitModel? {
        var stmt: OpaquePointer?
        var habitModel: HabitModel? = nil
        let query = "SELECT * FROM habit_daily_tasks WHERE id = ?"
        
        if sqlite3_prepare_v2(db, query, -1, &stmt, nil) != SQLITE_OK {
            print("Error preparing fetch query: \(String(cString: sqlite3_errmsg(db)!))")
            return nil
        }
        
        // Bind the id parameter to the statement
        if sqlite3_bind_int(stmt, 1, Int32(id)) != SQLITE_OK {
            print("Error binding id parameter: \(String(cString: sqlite3_errmsg(db)!))")
            return nil
        }
        
        if sqlite3_step(stmt) == SQLITE_ROW {
            let id = sqlite3_column_int(stmt, 0)
            let title = String(cString: sqlite3_column_text(stmt, 1))
            let habitDetails = String(cString: sqlite3_column_text(stmt, 2))
            let activityType = String(cString: sqlite3_column_text(stmt, 3))
            let timeOfTheDay = String(cString: sqlite3_column_text(stmt, 4))
            let accountId = sqlite3_column_int(stmt, 5)
            
            habitModel = HabitModel(id: Int(id), title: title, habitDetails: habitDetails, activityType: activityType, timeOfTheDay: timeOfTheDay, accountId: Int(accountId))
        }
        
        if sqlite3_finalize(stmt) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("Error finalizing fetch query: \(err)")
        }
        
        return habitModel
    }
    
    func fetchHabitDailyTaskByHabitId(id: Int) -> HabitModel? {
        var stmt: OpaquePointer?
        var habitModel: HabitModel? = nil
        let query = "SELECT * FROM habit_daily_tasks WHERE habit_id = ?"
        
        if sqlite3_prepare_v2(db, query, -1, &stmt, nil) != SQLITE_OK {
            print("Error preparing fetch query: \(String(cString: sqlite3_errmsg(db)!))")
            return nil
        }
        
        // Bind the id parameter to the statement
        if sqlite3_bind_int(stmt, 1, Int32(id)) != SQLITE_OK {
            print("Error binding id parameter: \(String(cString: sqlite3_errmsg(db)!))")
            return nil
        }
        
        if sqlite3_step(stmt) == SQLITE_ROW {
            let id = sqlite3_column_int(stmt, 0)
            let title = String(cString: sqlite3_column_text(stmt, 1))
            let habitDetails = String(cString: sqlite3_column_text(stmt, 2))
            let activityType = String(cString: sqlite3_column_text(stmt, 3))
            let timeOfTheDay = String(cString: sqlite3_column_text(stmt, 4))
            let accountId = sqlite3_column_int(stmt, 5)
            
            habitModel = HabitModel(id: Int(id), title: title, habitDetails: habitDetails, activityType: activityType, timeOfTheDay: timeOfTheDay, accountId: Int(accountId))
        }
        
        if sqlite3_finalize(stmt) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("Error finalizing fetch query: \(err)")
        }
        
        return habitModel
    }
    
    func deleteHabitDailyTaskById(id: Int) -> Bool {
        var stmt: OpaquePointer?
        let query = "DELETE FROM habit_daily_tasks WHERE id = ?"
        
        if sqlite3_prepare_v2(db, query, -1, &stmt, nil) != SQLITE_OK {
            print("Error preparing delete query: \(String(cString: sqlite3_errmsg(db)!))")
            return false
        }
        
        // Bind the id parameter to the statement
        if sqlite3_bind_int(stmt, 1, Int32(id)) != SQLITE_OK {
            print("Error binding id parameter: \(String(cString: sqlite3_errmsg(db)!))")
            return false
        }
        
        if sqlite3_step(stmt) == SQLITE_DONE {
            // Successfully deleted
            if sqlite3_finalize(stmt) != SQLITE_OK {
                let err = String(cString: sqlite3_errmsg(db)!)
                print("Error finalizing delete query: \(err)")
            }
            return true
        } else {
            print("Error deleting habit: \(String(cString: sqlite3_errmsg(db)!))")
            sqlite3_finalize(stmt)
            return false
        }
    }
}
