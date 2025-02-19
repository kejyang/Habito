//
//  AccountViewModelTests.swift
//  HabitoTests
//
//  Created by admin on 2/18/25.
//

import XCTest

@testable import Habito

final class AccountViewModelTests: XCTestCase {

    var accountViewModel: AccountViewModel!
    var dbManager: AccountDAO!
    
    var email = ""
    var password = ""
    
    override func setUp() {
        super.setUp()
        accountViewModel = AccountViewModel(isUnitTesting: true)
        
        dbManager = AccountDAO()
        dbManager.createDatabase(inMemory: true) // Use in-memory database for testing
        dbManager.createAccountTable()
        
        LoginValidator.shared.accountDB = dbManager
        
        insertSampleAccount()
        
        email = "test@gmail.com"
        password = "Qwerty123456!"
    }
    
    override func tearDown() {
        accountViewModel = nil
        dbManager = nil
        super.tearDown()
    }
    
    private func insertSampleAccount() {
        let username = "Test User"
        let email = "test@gmail.com"
        let password = "Qwerty123456!"
        
        dbManager.insertAccount(username: username as NSString, email: email as NSString, password: password as NSString)
    }
    
    
    func testValidateLogin_ReturnsTrue_ValidAccount() {
        XCTAssertTrue(accountViewModel.validateLogin(email: email, password: password))
    }

    func testValidateLogn_ReturnsFalse_InvalidAccount() {
        password = "sefsef"
        XCTAssertFalse(accountViewModel.validateLogin(email: email, password: password))
    }
}
