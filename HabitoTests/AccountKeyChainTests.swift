//
//  AccountKeyChainTests.swift
//  HabitoTests
//
//  Created by admin on 2/17/25.
//

import XCTest
@testable import Habito

final class AccountKeyChainTests: XCTestCase {

    let userDefaultSuiteName = "XCTest"
    var userDefault: UserDefaults!
    var accountKeyChain: AccountKeyChain!
    var dbManager: DBManager!
    let email = "XCTest19984294@xyz.com"
    let password = "Abc123!"
    var isRemember = false
    
    override func setUpWithError() throws {
        userDefault = UserDefaults(suiteName: userDefaultSuiteName)
        accountKeyChain = AccountKeyChain(userDefault: userDefault)
    }

    override func tearDownWithError() throws {
        userDefault.removePersistentDomain(forName: userDefaultSuiteName)
    }
    
    override func setUp() {
        super.setUp()
        dbManager = DBManager()
        dbManager.createDatabase(inMemory: true) // Use in-memory database for testing
        dbManager.createHabitTable() // Create the necessary table for testing
        
        isRemember = false
    }
    
    override func tearDown() {
        dbManager = nil
        super.tearDown()
    }
    
    
    func testSaveRememberAccount_SavesEmail_RememberIsTrue() {
        isRemember = true
        accountKeyChain.saveRememberAccount(email: email, isRememberMe: isRemember)
        let userEmail = accountKeyChain.userDefault.string(forKey: "email")
        XCTAssertFalse(userEmail!.isEmpty)
    }
    
    
    func testSaveRememberAccount_NoSave_RememberIsFalse() {
        isRemember = false
        accountKeyChain.saveRememberAccount(email: email, isRememberMe: isRemember)
        let userEmail = accountKeyChain.userDefault.string(forKey: "email")
        XCTAssertTrue(userEmail!.isEmpty)
    }
    
    func testGetRememberAccount_ReturnsEmail() {
        accountKeyChain.userDefault.set(email.lowercased(), forKey: "email")
        accountKeyChain.userDefault.set(true, forKey: "remember")
        let response = accountKeyChain.getRememberAccount()
        XCTAssertFalse(response.0.isEmpty)
    }
    
    func testClearRememberAccount_NoEmail() {
        accountKeyChain.userDefault.set(email.lowercased(), forKey: "email")
        accountKeyChain.userDefault.set(true, forKey: "remember")
        accountKeyChain.clearRememberAccount()
        let userId = accountKeyChain.userDefault.string(forKey: "email")
        let state = accountKeyChain.userDefault.bool(forKey: "remember")
        XCTAssertTrue(userId!.isEmpty)
        XCTAssertFalse(state)
    }
    
    
    
}
