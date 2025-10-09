//
//  ChannelUITests.swift
//  WalkieTalkieUITests
//

//

import XCTest

final class ChannelUITests: XCTestCase {
    
    func testChannelSuccessful() throws {
        let app = XCUIApplication()
        app.launch()
        
        let loginEmailTextField = app.textFields["loginEmail"]
        loginEmailTextField.tap()
        loginEmailTextField.typeText("carlosj@example.com")
        
        let loginPasswordSecureTextField = app.secureTextFields["loginPassword"]
        loginPasswordSecureTextField.tap()
        loginPasswordSecureTextField.typeText("123456")
        
        app.buttons["loginEnter"].tap()
        
        app.staticTexts["Desconectado"].tap()
        app.cells.containing(.staticText, identifier: "canal-1").firstMatch.tap()
        app.buttons["Pulsa para hablar"].firstMatch.press(forDuration: 2.1)
        app/*@START_MENU_TOKEN@*/.buttons["Ver usuarios"]/*[[".otherElements.buttons[\"Ver usuarios\"]",".buttons[\"Ver usuarios\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.firstMatch.tap()
        
        app.staticTexts["Desconectar"].firstMatch.tap()
        
        app.buttons["Cerrar sesión"].tap()
        app.otherElements.matching(identifier: "Horizontal scroll bar, 1 page").element(boundBy: 1).tap()
    }
}
