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

    func testLoginNoAccount() throws {
        skipOnboarding()
        let emailTextfield = app.textFields["loginEmailTextfield"]
        let passwordTextField = app.textFields["loginPasswordTextfield"]
        let loginButton = app.buttons["loginButton"]
        emailTextfield.tap()
    }

}
