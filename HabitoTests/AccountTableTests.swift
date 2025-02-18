//
//  AccountTableTests.swift
//  HabitoTests
//
//  Created by Kenneth Yang on 2/18/25.
//

import XCTest
@testable import Habito

final class AccountTableTests: XCTestCase {

    var dbManager: DBManager!
    
    override func setUp() {
        super.setUp()
        dbManager = DBManager()
        dbManager.createDatabase(inMemory: true) // Use in-memory database for testing
        dbManager.createHabitDailyTaskTable() // Create the necessary table for testing
        dbManager.createAccountTable()
        insertSampleAccount()
    }
    
    override func tearDown() {
        dbManager = nil
        super.tearDown()
    }

    private func insertSampleAccount() {
        let username = "Test User"
        let email = "test@gmail.com"
        let password = "testpass"
        
        dbManager.insertAccount(username: username as NSString, email: email as NSString, password: password as NSString)
    }
    
    private func fetchFirstAccountId() -> Int32 {
        let account = dbManager.fetchAccountByEmail(email: "test@gmail.com" as NSString)
        return account!.id
    }

    func testInsertAccount() {
        insertSampleAccount()
        let account = dbManager.fetchAccountByEmail(email: "test@gmail.com")
        XCTAssertNotNil(account)
        XCTAssertEqual(account?.username, "Test User")
        XCTAssertEqual(account?.password, "testpass")
    }
    
    func testFetchAccountByEmail() {
        let account = dbManager.fetchAccountByEmail(email: "test@gmail.com")
        let fetchedAccount = dbManager.fetchAccountByEmail(email: "test@gmail.com")
        XCTAssertNotNil(fetchedAccount)
    }
    
    func testDeleteAccountById() {
        let accountId = fetchFirstAccountId()
        dbManager.deleteAccountByID(id: accountId)
    }
    
}
