//
//  SignupValidatorTests.swift
//  HabitoTests
//
//  Created by admin on 2/17/25.
//

import XCTest

@testable import Habito

final class SignupValidatorTests: XCTestCase {

    private var username: String = ""
    private var email: String = ""
    private var password: String = ""
    private var confirmPassword: String = ""

    private var responseEnum = SignupValidator.ValidationResponse.self
    
    override func setUp() {
        super.setUp()
        username = "This is a test username"
        email = "testusername777145@xyz.com"
        password = "Abc123!"
        confirmPassword = "Abc123!"
    }
    
    func testValidate_Unsuccessful_EmailEmpty() {
        email = ""
        let response = SignupValidator.shared.validate(username: username, email: email, password: password, confirmPassword: confirmPassword)
        XCTAssertTrue(response.contains(responseEnum.emailEmpty))
    }
    
    func testValidate_Unsuccessful_EmailContainsSpace() {
        email = "test user name 777145@xyz.com"
        let response = SignupValidator.shared.validate(username: username, email: email, password: password, confirmPassword: confirmPassword)
        XCTAssertTrue(response.contains(responseEnum.emailContainsSpace))
    }
    
    func testValidate_Unsuccessful_EmailBadFormat() {
        email = "somethingsomethingtestuser12355.c"
        let response = SignupValidator.shared.validate(username: username, email: email, password: password, confirmPassword: confirmPassword)
        XCTAssertTrue(response.contains(responseEnum.invalidEmailFormat))
    }
    
    func testValidate_Unsuccessful_PasswordShort() {
        password = "A1!"
        let response = SignupValidator.shared.validate(username: username, email: email, password: password, confirmPassword: confirmPassword)
        XCTAssertTrue(response.contains(responseEnum.passwordNotLong))
    }
    
    func testValidate_Unsuccessful_PasswordNoNumber() {
        password = "AAA!!!"
        let response = SignupValidator.shared.validate(username: username, email: email, password: password, confirmPassword: confirmPassword)
        XCTAssertTrue(response.contains(responseEnum.passwordNoNumber))
    }
    
    func testValidate_Unsuccessful_PasswordNoCapital() {
        password = "a1!"
        let response = SignupValidator.shared.validate(username: username, email: email, password: password, confirmPassword: confirmPassword)
        XCTAssertTrue(response.contains(responseEnum.passwordNoCapital))
    }
    
    func testValidate_Unsuccessful_PasswordNoSpecialCharacter() {
        password = "A1aaaaaaaa"
        let response = SignupValidator.shared.validate(username: username, email: email, password: password, confirmPassword: confirmPassword)
        XCTAssertTrue(response.contains(responseEnum.passwordNoSpecialCharacter))
    }
    
    func testValidate_Unsuccessful_PasswordsNotMatching() {
        confirmPassword = "Abc123!!!"
        let response = SignupValidator.shared.validate(username: username, email: email, password: password, confirmPassword: confirmPassword)
        XCTAssertTrue(response.contains(responseEnum.passwordNotMatching))
    }
    
    func testValidate_Successful_ValidSignup() {
        let response = SignupValidator.shared.validate(username: username, email: email, password: password, confirmPassword: confirmPassword)
        XCTAssertTrue(response.isEmpty)
    }

}
