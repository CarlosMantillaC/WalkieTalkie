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
        
        let loginEmailTextField = app/*@START_MENU_TOKEN@*/.textFields["loginEmail"]/*[[".otherElements",".textFields[\"Correo Electronico\"]",".textFields[\"loginEmail\"]",".textFields.firstMatch"],[[[-1,2],[-1,1],[-1,3],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        loginEmailTextField.tap()
        loginEmailTextField.typeText("carlosj@example.com")
        
        let loginPasswordSecureTextField = app/*@START_MENU_TOKEN@*/.secureTextFields["loginPassword"]/*[[".otherElements",".secureTextFields[\"Contraseña\"]",".secureTextFields[\"loginPassword\"]",".secureTextFields.firstMatch"],[[[-1,2],[-1,1],[-1,3],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        loginPasswordSecureTextField.tap()
        loginPasswordSecureTextField.typeText("123456")
        
        app/*@START_MENU_TOKEN@*/.buttons["loginEnter"]/*[[".buttons.containing(.staticText, identifier: \"Entrar\").firstMatch",".otherElements",".buttons[\"Entrar\"]",".buttons[\"loginEnter\"]"],[[[-1,3],[-1,2],[-1,1,1],[-1,0]],[[-1,3],[-1,2]]],[0]]@END_MENU_TOKEN@*/.tap()

        app.cells/*@START_MENU_TOKEN@*/.containing(.staticText, identifier: "canal-1").firstMatch/*[[".element(boundBy: 0)",".containing(.staticText, identifier: \"canal-1\").firstMatch"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.buttons["microphone off"].press(forDuration: 1.5);/*[[".scrollViews.buttons.firstMatch",".tap()",".press(forDuration: 1.5);",".otherElements.buttons[\"microphone off\"]",".buttons[\"microphone off\"]"],[[[-1,4,1],[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/
        app/*@START_MENU_TOKEN@*/.buttons["Salir"]/*[[".navigationBars",".buttons.firstMatch",".buttons[\"Salir\"]"],[[[-1,2],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.buttons["Cerrar sesión"]/*[[".navigationBars.buttons[\"Cerrar sesión\"]",".buttons.firstMatch",".buttons[\"Cerrar sesión\"]"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.otherElements.matching(identifier: "Horizontal scroll bar, 1 page").element(boundBy: 1).tap()
    }
}
