//
//  RegisterUITests.swift
//  WalkieTalkieUITests
//

//

import XCTest

final class RegisterUITests: XCTestCase {
    
    func testRegisterSuccessful() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["Registrarse"].tap()
        
        let registerNameTextField = app.textFields["registerName"]
        registerNameTextField.tap()
        registerNameTextField.typeText("Jose")
        
        let registerLastNameTextField = app.textFields["registerLastName"]
        registerLastNameTextField.tap()
        registerLastNameTextField.typeText("Perez")
        
        let registerEmailTextField = app.textFields["registerEmail"]
        registerEmailTextField.tap()
        registerEmailTextField.typeText("jose@example.com")
        
        let registerPasswordField = app.secureTextFields["registerPassword"]
        registerPasswordField.tap()
        registerPasswordField.typeText("123456")
        
        let registerConfirmPasswordField = app.secureTextFields["registerConfirmPassword"]
        registerConfirmPasswordField.tap()
        registerConfirmPasswordField.typeText("123456")
        
        if app.keyboards.buttons["intro"].exists {
            app.keyboards.buttons["intro"].tap()
        } else if app.keyboards.buttons["Return"].exists {
            app.keyboards.buttons["Return"].tap()
        } else {
            app.navigationBars.element(boundBy: 0).tap()
        }
        app.buttons["registerSend"].tap()
        
        let alert = app.alerts.element
        XCTAssertTrue(alert.waitForExistence(timeout: 5))
        
        let okButton = alert.buttons.element(boundBy: 0)
        XCTAssertTrue(okButton.exists)
        okButton.tap()
    }
}
