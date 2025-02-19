//
//  AccountDAO.swift
//  Habito
//
//  Created by admin on 2/12/25.
//

import Foundation
import SQLite3

class AccountDAO {
    static var shared = AccountDAO()
    private var db: OpaquePointer?
    private var accountList = [AccountModel]()
    
    init() {}
    
    func createDatabase(inMemory: Bool = false) {
        let fPath: URL
        
        if inMemory {
            // Use in-memory database for testing
            fPath = URL(string: "file::memory:")!
        } else {
            // Use the actual database file
            fPath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("habito.sqlite")
        }
        
        print("path is ", fPath)
        if sqlite3_open(fPath.path, &db) != SQLITE_OK {
            print("can not open database")
        }
    }
    
    func createDatabase() {
        
        let fPath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("habito.sqlite")
        
        if sqlite3_open(fPath.path, &db) != SQLITE_OK {
            print("Cannot open database")
        }
    }
    
    func createAccountTable() {
        
        let sql = "CREATE TABLE IF NOT EXISTS account(id INTEGER PRIMARY KEY AUTOINCREMENT, username TEXT, email TEXT, password TEXT)"
        
        if sqlite3_exec(db,sql,nil,nil,nil) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("An error occurred: \(err)")
        }
    }

    
    func insertAccount(username: NSString, email: NSString, password: NSString) {
        var stmt : OpaquePointer?
        let query = "INSERT INTO account(username, email, password) values (?,?,?)"
        if sqlite3_prepare_v2(db, query, -1, &stmt, nil) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("An error occurred: \(err)")
        }
        
        if sqlite3_bind_text(stmt, 1, username.utf8String, -1, nil) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("An error occurred: \(err)")
        }
        
        if sqlite3_bind_text(stmt, 2, email.utf8String, -1, nil) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("An error occurred: \(err)")
        }
        
        if sqlite3_bind_text(stmt, 3, password.utf8String, -1, nil) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("An error occurred: \(err)")
        }
        
        if sqlite3_step(stmt) != SQLITE_DONE {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("An error occurred: \(err)")
        } else {
            print("Account saved")
        }
    }
    
    func fetchAccountByEmail(email: NSString) -> AccountModel? {
        var fetchedAccount : AccountModel?
        var stmt : OpaquePointer?
        let query = "SELECT * FROM account WHERE email = ?"
        
        if sqlite3_prepare_v2(db, query, -1, &stmt, nil) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("An error occurred: \(err)")
        }
        
        if sqlite3_bind_text(stmt, 1, email.utf8String, -1, nil) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("An error occurred: \(err)")
        }
        
        if sqlite3_step(stmt) == SQLITE_ROW {
            let id = sqlite3_column_int(stmt, 0)
            let fetchedUsername = String(cString: sqlite3_column_text(stmt, 1))
            let fetchedEmail = String(cString: sqlite3_column_text(stmt, 2))
            let fetchedPassword = String(cString: sqlite3_column_text(stmt, 3))
            
            fetchedAccount = AccountModel(id: id, username: fetchedUsername, email: fetchedEmail, password: fetchedPassword)
        } else {
            print("Could not get account")
        }
        
        sqlite3_finalize(stmt)
        
        return fetchedAccount
    }
    
    func fetchAccountByEmailAndPassword(email: NSString, password: NSString) -> AccountModel? {
        var fetchedAccount : AccountModel?
        var stmt : OpaquePointer?
        let query = "SELECT * FROM account WHERE email = ? AND password = ?"
        
        if sqlite3_prepare_v2(db, query, -1, &stmt, nil) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("An error occurred: \(err)")
        }
        
        if sqlite3_bind_text(stmt, 1, email.utf8String, -1, nil) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("An error occurred: \(err)")
        }
        
        if sqlite3_bind_text(stmt, 2, password.utf8String, -1, nil) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("An error occurred: \(err)")
        }
        
        if sqlite3_step(stmt) == SQLITE_ROW {
            let id = sqlite3_column_int(stmt, 0)
            let fetchedUsername = String(cString: sqlite3_column_text(stmt, 1))
            let fetchedEmail = String(cString: sqlite3_column_text(stmt, 2))
            let fetchedPassword = String(cString: sqlite3_column_text(stmt, 3))
            
            fetchedAccount = AccountModel(id: id, username: fetchedUsername, email: fetchedEmail, password: fetchedPassword)
        } else {
            print("Could not get account")
        }
        
        sqlite3_finalize(stmt)
        
        return fetchedAccount
    }
    
    func deleteAccountByID(id: Int32) {
        var stmt : OpaquePointer?
        let query = "DELETE FROM account WHERE id = ?"
        if sqlite3_prepare_v2(db, query, -1, &stmt, nil) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("An error occurred: \(err)")
        }
        
        if sqlite3_bind_int(stmt, 1, id) != SQLITE_OK {
            let err = String(cString: sqlite3_errmsg(db)!)
            print("An error occurred: \(err)")
        }
        
        if sqlite3_step(stmt) == SQLITE_DONE {
            print("Account deleted")
        } else {
            print("Account could not be deleted")
        }
    }
    
    
}
