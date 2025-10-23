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
        
        let enterButton = app.buttons["loginEnter"].firstMatch
        enterButton.tap()
        
        let disconnectedStatic = app.staticTexts["Desconectado"].firstMatch
        disconnectedStatic.tap()
        
        let canal1 = app.staticTexts["canal-1"].firstMatch
        canal1.tap()
        
        let talkButton = app.buttons["Pulsa para hablar"].firstMatch
        talkButton.press(forDuration: 1.1)
        
        let disconnectButton = app.buttons["Desconectar"].firstMatch
        disconnectButton.tap()
        
        disconnectedStatic.tap()

        let crearButton = app.buttons["Crear"].firstMatch
        crearButton.tap()
        
        let nameChannel = app.textFields["Ingrese el nombre del canal"]
        nameChannel.tap()
        nameChannel.typeText("fesc-1")
        
        let PINChannel = app.textFields["Ingrese el PIN del canal"]
        PINChannel.tap()
        PINChannel.typeText("1234")
        
        let crearStatic = app.staticTexts["Crear"].firstMatch
        crearStatic.tap()
        
        let okAlertButton = app.buttons["OK"].firstMatch
        okAlertButton.tap()
        
        let sheet = app.otherElements.containing(.staticText, identifier: "Crea un Canal Privado").firstMatch
        if sheet.exists {
            let startCoordinate = sheet.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.2))
            let endCoordinate = sheet.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.8))
            startCoordinate.press(forDuration: 0.1, thenDragTo: endCoordinate)
        }
        
        let listSheet = app.otherElements.containing(.staticText, identifier: "Lista de Canales").firstMatch
        if listSheet.exists {
            let startCoordinate = listSheet.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.2))
            let endCoordinate = listSheet.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.8))
            startCoordinate.press(forDuration: 0.1, thenDragTo: endCoordinate)
        }

        sleep(1)

        let settingsButton = app.buttons["settingsButton"].firstMatch
        if !settingsButton.waitForExistence(timeout: 10) {
            print(app.debugDescription)
        }
        settingsButton.tap()
        
        let logoutOption = app.staticTexts["Cerrar Sesión"].firstMatch
        logoutOption.tap()

        let confirmAlert = app.alerts.element(boundBy: 0)

        let confirmLogoutButton = confirmAlert.buttons["Cerrar Sesión"]
        confirmLogoutButton.tap()

        let successAlert = app.alerts["Sesión cerrada"]

        let okButton = successAlert.buttons["OK"]
        okButton.tap()
    }
}
