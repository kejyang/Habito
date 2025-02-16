//This is for handling the Habits table.

import Foundation
import SQLite3
extension DBManager{
    func createHabitTable() {
        let sql = "create table if not exists habits(id integer primary key autoincrement,title text, habit_details text, activity_type text, time_of_the_day text, account_id INTEGER, created_day INTEGER, created_month INTEGER, created_year INTEGER, FOREIGN KEY (account_id) REFERENCES account(id))"
        if sqlite3_exec(db,sql,nil,nil,nil) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("there is an error \(err)")
        }
    }
    
    
    func appendCreationDateToHabitTable() {
        var sql = "ALTER TABLE habits ADD COLUMN created_day INTEGER DEFAULT 1"
        if sqlite3_exec(db,sql,nil,nil,nil) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("An error occurred: \(err)")
        }
        sql = "ALTER TABLE habits ADD COLUMN created_month INTEGER DEFAULT 1"
        if sqlite3_exec(db,sql,nil,nil,nil) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("An error occurred: \(err)")
        }
        sql = "ALTER TABLE habits ADD COLUMN created_year INTEGER DEFAULT 2025"
        if sqlite3_exec(db,sql,nil,nil,nil) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("An error occurred: \(err)")
        }
    }
    
    
    func insertHabit(title: String, habitDetails: String, activityType: String, timeOfTheDay: String, accountId: Int) {
        var stmt: OpaquePointer?
        let titleNSString = title as NSString
        let habitDetailsNSString = habitDetails as NSString
        let activityTypeNSString = activityType as NSString
        let timeOfTheDayNSString = timeOfTheDay as NSString
        
        let query = "INSERT INTO habits(title, habit_details, activity_type, time_of_the_day, account_id, created_day, created_month, created_year) VALUES (?, ?, ?, ?, ?, ?, ?, ?)"
        
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
        
        let today = Date()
        let components = Calendar.current.dateComponents([.day, .month, .year], from: today)
        guard let day = components.day else {
            print("Unable to retrieve day")
            return
        }
        guard let month = components.month else {
            print("Unable to retrieve month")
            return
        }
        guard let year = components.year else {
            print("Unable to retrieve year")
            return
        }
        
        if sqlite3_bind_int(stmt, 6, Int32(day)) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("There is an error binding creation day: \(err)")
            return
        }
        
        if sqlite3_bind_int(stmt, 7, Int32(month)) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("There is an error binding creation month: \(err)")
            return
        }
        
        if sqlite3_bind_int(stmt, 8, Int32(year)) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("There is an error binding creation year: \(err)")
            return
        }
        
        // Execute the query
        if sqlite3_step(stmt) != SQLITE_DONE {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("There is an error in inserting data: \(err)")
        } else {
            print("Data inserted successfully into habits")
        }
        
        // Finalize the statement
        if sqlite3_finalize(stmt) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("Error finalizing insert statement: \(err)")
        }
    }
    
    func fetchHabits() -> [HabitModel] {
        var stmt: OpaquePointer?
        var habitList = [HabitModel]()
        let query = "SELECT * FROM habits"
        
        if sqlite3_prepare_v2(db, query, -1, &stmt, nil) != SQLITE_OK {
            print("Error preparing fetch query: \(String(cString: sqlite3_errmsg(db)!))")
            return habitList
        }
        
        while sqlite3_step(stmt) == SQLITE_ROW {
            let id = sqlite3_column_int(stmt, 0)
            let title = String(cString: sqlite3_column_text(stmt, 1))
            let habitDetails = String(cString: sqlite3_column_text(stmt, 2))
            let activityType = String(cString: sqlite3_column_text(stmt, 3))
            let timeOfTheDay = String(cString: sqlite3_column_text(stmt, 4))
            let accountId = sqlite3_column_int(stmt, 5)
            let createdDay = sqlite3_column_int(stmt, 6)
            let createdMonth = sqlite3_column_int(stmt, 7)
            let createdYear = sqlite3_column_int(stmt, 8)
            
            let habitModel = HabitModel(id: Int(id), title: title, habitDetails: habitDetails, activityType: activityType, timeOfTheDay: timeOfTheDay, accountId: Int(accountId), createdDay: Int(createdDay), createdMonth: Int(createdMonth), createdYear: Int(createdYear))
            habitList.append(habitModel)
        }
        if sqlite3_finalize(stmt) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("Error finalizing fetch query: \(err)")
        }
        return habitList
    }
    
    func fetchHabitsByAccountId(id : Int) -> [HabitModel] {
        var stmt: OpaquePointer?
        var habitList = [HabitModel]()
        let query = "SELECT * FROM habits WHERE account_id = ?"
        
        if sqlite3_prepare_v2(db, query, -1, &stmt, nil) != SQLITE_OK {
            print("Error preparing fetch query: \(String(cString: sqlite3_errmsg(db)!))")
            return habitList
        }
        
        if sqlite3_bind_int(stmt, 1, Int32(id)) != SQLITE_OK {
            print("Error binding id parameter: \(String(cString: sqlite3_errmsg(db)!))")
            return []
        }
        
        while sqlite3_step(stmt) == SQLITE_ROW {
            let id = sqlite3_column_int(stmt, 0)
            let title = String(cString: sqlite3_column_text(stmt, 1))
            let habitDetails = String(cString: sqlite3_column_text(stmt, 2))
            let activityType = String(cString: sqlite3_column_text(stmt, 3))
            let timeOfTheDay = String(cString: sqlite3_column_text(stmt, 4))
            let accountId = sqlite3_column_int(stmt, 5)
            let createdDay = sqlite3_column_int(stmt, 6)
            let createdMonth = sqlite3_column_int(stmt, 7)
            let createdYear = sqlite3_column_int(stmt, 8)
            
            let habitModel = HabitModel(id: Int(id), title: title, habitDetails: habitDetails, activityType: activityType, timeOfTheDay: timeOfTheDay, accountId: Int(accountId), createdDay: Int(createdDay), createdMonth: Int(createdMonth), createdYear: Int(createdYear))
            habitList.append(habitModel)
        }
        if sqlite3_finalize(stmt) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("Error finalizing fetch query: \(err)")
        }
        return habitList
    }
    
    func fetchHabitById(id: Int) -> HabitModel? {
        var stmt: OpaquePointer?
        var habitModel: HabitModel? = nil
        let query = "SELECT * FROM habits WHERE id = ?"
        
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
            let createdDay = sqlite3_column_int(stmt, 6)
            let createdMonth = sqlite3_column_int(stmt, 7)
            let createdYear = sqlite3_column_int(stmt, 8)
            
            habitModel = HabitModel(id: Int(id), title: title, habitDetails: habitDetails, activityType: activityType, timeOfTheDay: timeOfTheDay, accountId: Int(accountId), createdDay: Int(createdDay), createdMonth: Int(createdMonth), createdYear: Int(createdYear))
        }
        
        if sqlite3_finalize(stmt) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("Error finalizing fetch query: \(err)")
        }
        
        return habitModel
    }
    
    func deleteHabitById(id: Int) -> Bool {
        var stmt: OpaquePointer?
        let query = "DELETE FROM habits WHERE id = ?"
        
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
