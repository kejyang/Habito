//
//  LoginValidatorTests.swift
//  HabitoTests
//
//  Created by admin on 2/18/25.
//

import XCTest

@testable import Habito

final class LoginValidatorTests: XCTestCase {

    var loginValidator: LoginValidator!
    var email = ""
    var password = ""
    
    override func setUp() {
        super.setUp()
        
        loginValidator = LoginValidator(isUnitTesting: true)

        loginValidator.accountDB = AccountDAO()
        loginValidator.accountDB.createDatabase(inMemory: true) // Use in-memory database for testing
        loginValidator.accountDB.createAccountTable()
        insertSampleAccount()
        
        email = "test@gmail.com"
        password = "Qwerty123456!"
    }
    
    override func tearDown() {
        loginValidator = nil
        super.tearDown()
    }
    
    private func insertSampleAccount() {
        let username = "Test User"
        let email = "test@gmail.com"
        let password = "Qwerty123456!"
        
        loginValidator.accountDB.insertAccount(username: username as NSString, email: email as NSString, password: password as NSString)
    }
    
    
    func testLoginValidator_ReturnsTrue_ValidAccount() {
        XCTAssertTrue(loginValidator.validate(email: email, password: password))
    }
    
    func testLoginValidator_ReturnsFalse_InvalidAccount() {
        password = "sefefef"
        XCTAssertFalse(loginValidator.validate(email: email, password: password))
    }
}
