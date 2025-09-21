//
//  TaskAppUITests.swift
//  TaskAppUITests
//
//  Created by Gopenux on 21/09/25.
//

import XCTest

final class TaskAppUITests: XCTestCase {

    @MainActor
    func testTaskApp() throws {
        
        let app = XCUIApplication()
        app.activate()
        app.buttons["Add"].tap()
        
        let title = app.textFields["Título"]
        title.tap()
        title.typeText("hola")
        
        let descripciNTextField = app.textFields["Descripción (opcional)"]
        descripciNTextField.tap()
        descripciNTextField.typeText("hola")
        
        let mediaButton = app.buttons["Media"]
        mediaButton.tap()
        app.staticTexts["Guardar"].tap()
        
        let altaButton = app.buttons["Alta"]
        altaButton.tap()
        mediaButton.tap()
        app.buttons["Baja"].tap()
        app.buttons["Pendientes"].tap()
        app.buttons["Completadas"].tap()
        altaButton.tap()
        
        let todasElementsQuery = app.buttons.matching(identifier: "Todas")
        todasElementsQuery.element(boundBy: 0).tap()
        todasElementsQuery.element(boundBy: 1).tap()
        
        let firstCell = app.tables.cells.element(boundBy: 0)
        XCTAssertTrue(firstCell.exists, "La celda debería existir")

        firstCell.swipeLeft()
        app.buttons["Completar"].tap()

        firstCell.swipeLeft()
        app.buttons["Eliminar"].tap()
    }
}
