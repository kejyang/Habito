//
//  CreateAccountUITests.swift
//  HabitoUITests
//
//  Created by Kenneth Yang on 2/18/25.
//

import XCTest

final class CreateAccountUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["UI_TESTING"]
        app.launch()
    }

    override func tearDownWithError() throws {
        app.terminate()
        app = nil
    }
    
    private func skipOnboarding() {
        let skipText = app.staticTexts["skipOnboardingText"]
        skipText.tap()
    }

    //This is not done
    func testLoginNoAccount() throws {
        skipOnboarding()
        let emailTextfield = app.textFields["loginEmailTextfield"]
        emailTextfield.tap()
        emailTextfield.typeText("NewUsername")
        let passwordTextField = app.textFields["loginPasswordTextfield"]
        let loginButton = app.buttons["loginButton"]
        emailTextfield.tap()
        loginButton.tap()
    }
    
    func testSignUp() throws {
        skipOnboarding()
        let signUpButton = app.buttons["signUpButton"]
        signUpButton.tap()
        let usernameTextfield = app.textFields["signUpUsernameTextField"]
        let emailTextfield = app.textFields["signUpEmailTextField"]
        let passwordTextfield = app.secureTextFields["signUpPasswordTextField"]
        let confirmPasswordTextfield = app.secureTextFields["signUpConfirmPasswordTextField"]
        let signUpButton2 = app.buttons["signUpButton2"]
        usernameTextfield.tap()
        usernameTextfield.typeText("test1")
        emailTextfield.tap()
        emailTextfield.typeText("test1@gmail.com")
        passwordTextfield.tap()
        passwordTextfield.typeText("TestPass1")
        confirmPasswordTextfield.tap()
        confirmPasswordTextfield.typeText("TestPass1")
        signUpButton2.tap()
        
    }

}
