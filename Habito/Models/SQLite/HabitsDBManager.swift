//This is for handling the Habits table.

import Foundation
import SQLite3
extension DBManager{
    func createHabitTable() {
        let sql = "create table if not exists habits_table(id integer primary key autoincrement,title text, habit_details text, activity_type text, time_of_the_day text, FOREIGN KEY (account_id) REFERENCES account_table(id))"
        if sqlite3_exec(db,sql,nil,nil,nil) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("there is an error \(err)")
        }
    }
    
    func insertHabitData(title: String, habitDetails: String, activityType: String, timeOfTheDay: String, accountId: Int) {
        var stmt: OpaquePointer?
        let titleNSString = title as NSString
        let habitDetailsNSString = habitDetails as NSString
        let activityTypeNSString = activityType as NSString
        let timeOfTheDayNSString = timeOfTheDay as NSString
        
        let query = "INSERT INTO habits_table (title, habit_details, activity_type, time_of_the_day, account_id) VALUES (?, ?, ?, ?, ?)"
        
        // Prepare the statement
        if sqlite3_prepare_v2(db, query, -1, &stmt, nil) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("There is an error in preparing the query: \(err)")
            return
        }
        
        // Bind parameters
        if sqlite3_bind_text(stmt, 1, titleNSString.utf8String, -1, nil) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("There is an error binding title: \(err)")
            return
        }
        
        if sqlite3_bind_text(stmt, 2, habitDetailsNSString.utf8String, -1, nil) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("There is an error binding habit details: \(err)")
            return
        }
        
        if sqlite3_bind_text(stmt, 3, activityTypeNSString.utf8String, -1, nil) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("There is an error binding activity type: \(err)")
            return
        }
        
        if sqlite3_bind_text(stmt, 4, timeOfTheDayNSString.utf8String, -1, nil) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("There is an error binding time of the day: \(err)")
            return
        }
        
        if sqlite3_bind_int(stmt, 5, Int32(accountId)) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("There is an error binding account_id: \(err)")
            return
        }
        
        // Execute the query
        if sqlite3_step(stmt) != SQLITE_DONE {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("There is an error in inserting data: \(err)")
        } else {
            print("Data inserted successfully into habits_table")
        }
        
        // Finalize the statement
        if sqlite3_finalize(stmt) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("Error finalizing insert statement: \(err)")
        }
    }
}
