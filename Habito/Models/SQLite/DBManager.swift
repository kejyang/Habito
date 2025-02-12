//
//  DBHelper.swift
//  Habito
//
//  Created by Kenneth Yang on 2/12/25.
//

import Foundation
import SQLite3

class DBManager {
    
    static var dbhelper = DBManager()
    var db: OpaquePointer?
    
    func createDatabase() {
        let fPath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil,create : false).appendingPathComponent("habitoDB.sqlite")
        
        print("path is ",fPath)
        if sqlite3_open(fPath.path, &db) != SQLITE_OK {
            print("can not open database")
        }
    }
    
    func createTestTable() {
        let sql = "create table if not exists testTable(id integer primary key autoincrement,title text)"
        if sqlite3_exec(db,sql,nil,nil,nil) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("there is an error \(err)")
        }
    }

    func insertData(title : String) {
        var stmt : OpaquePointer?
        let titleNSString = title as NSString
        
        let query = "insert into testTable(title) values(?)"
        if sqlite3_prepare_v2(db, query, -1, &stmt, nil) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("there is an error \(err)")
        }
        if sqlite3_bind_text(stmt, 1, titleNSString.utf8String, -1, nil) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("there is an error in title\(err)")
        }
        if sqlite3_step(stmt) != SQLITE_DONE {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("there is an error \(err)")
        }
        else{
            print("data saved")
        }
    }
    
    func fetchData() -> [TestModel] {
        var stmt: OpaquePointer?
        var testList = [TestModel]()
        let query = "SELECT * FROM testTable"
        
        if sqlite3_prepare_v2(db, query, -1, &stmt, nil) != SQLITE_OK {
            print("Error preparing fetch query: \(String(cString: sqlite3_errmsg(db)!))")
            return testList
        }
        
        while sqlite3_step(stmt) == SQLITE_ROW {
            let id = sqlite3_column_int(stmt, 0)
            let title = String(cString: sqlite3_column_text(stmt, 1))
            let testModel = TestModel(id: Int(id), title: title)
            testList.append(testModel)
        }
        if sqlite3_finalize(stmt) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("Error finalizing fetch query: \(err)")
        }
        return testList
    }
    
    /*func fetchDataByName(name:String)->Student {
        
        let query = "select * from student where name = '\(name)'"
        var stmt : OpaquePointer?
        var stu : Student?
        if sqlite3_prepare(db, query, -1, &stmt, nil) == SQLITE_OK {
            while sqlite3_step(stmt) == SQLITE_ROW {
                let name = String(cString: sqlite3_column_text(stmt, 1))
                let course = String(cString: sqlite3_column_text(stmt, 2))
            stu = Student(name: name, course: course)
            }
            
        }
        else {
            print("name not found")
        }
        return stu!
    }*/
    
    /*func UpdateData(name:String, course: NSString) {
        var stmt : OpaquePointer?
        let query = "update student set course = '\(course)' where name = '\(name)'"
        if sqlite3_prepare(db, query, -1, &stmt, nil) == SQLITE_OK {
            sqlite3_bind_text(stmt, 2, course.utf8String, -1, nil)
            if sqlite3_step(stmt) == SQLITE_DONE {
                print( "updated successfully")
                
            }
            else {
                print("update failed")
            }
        }
        sqlite3_finalize(stmt)
        
    }
   
    func deleteData(name:String) {
        var stmt : OpaquePointer?
        let query = "delete from student where name = '\(name)'"
        if sqlite3_prepare(db, query, -1, &stmt, nil) == SQLITE_OK {
            if sqlite3_step(stmt) == SQLITE_DONE {
                print("data deleted successfully")
                
            }
            else {
                print("delete failed")
            }
        }
        sqlite3_finalize(stmt)
    }
     */
    
}
