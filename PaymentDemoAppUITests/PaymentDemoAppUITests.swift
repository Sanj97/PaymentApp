//
//  PaymentDemoAppUITests.swift
//  PaymentDemoAppUITests
//
//  Created by Sanjar Yalgashev on 08/05/25.
//

import XCTest

final class PaymentDemoAppUITests: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUp() {
        continueAfterFailure = false
        app.launch()
    }
    
    func testGreetingToAuthFlow() {
        // Wait 2 seconds for greeting animation to finish
        sleep(2)
        
        let loginText = app.staticTexts["Welcome Back"]
        XCTAssertTrue(loginText.waitForExistence(timeout: 2))
    }
    
    func testLoginFlowWithValidCredentials() {
        sleep(2) // wait for greeting screen
        
        let usernameField = app.textFields["username_field"]
        XCTAssertTrue(usernameField.exists)
        usernameField.tap()
        usernameField.typeText("admin")
        
        let passwordField = app.secureTextFields["password_field"]
        XCTAssertTrue(passwordField.exists)
        passwordField.tap()
        passwordField.typeText("1234")
        
        app.buttons["login_button"].tap()
    }
    
    func testLoginFailsWithWrongCredentials() {
        sleep(2)
        
        app.textFields["username_field"].tap()
        app.textFields["username_field"].typeText("wrong")
        
        app.secureTextFields["password_field"].tap()
        app.secureTextFields["password_field"].typeText("bad")
        
        app.buttons["login_button"].tap()
        
        let errorText = app.staticTexts["Invalid username or password."]
        XCTAssertTrue(errorText.waitForExistence(timeout: 3))
    }
}
