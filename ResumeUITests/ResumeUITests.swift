//
//  ResumeUITests.swift
//  ResumeUITests
//
//  Created by Новгородцев Никита on 22.08.2023.
//

import XCTest

final class ResumeUITests: XCTestCase {

    var app: XCUIApplication!
    override func setUpWithError() throws {
        app = XCUIApplication()
        app.launch()
        continueAfterFailure = false

    }

    override func tearDownWithError() throws {
        app = nil
    }

    func testDeleteItem() throws {
        app.buttons["editButton"].tap()
        app.buttons["deleteButton4"].tap()
        app.buttons["deleteButton2"].tap()
        app.buttons["deleteButton5"].tap()
        app.buttons["deleteButton0"].tap()
        
        app.buttons["editButton"].tap()
    }
    
    func testAddItem() throws {
        app.buttons["editButton"].tap()
        let tablesQuery = app.tables
        
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["+"]/*[[".cells.staticTexts[\"+\"]",".staticTexts[\"+\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app.textFields["Введите название"].typeText("Unit test")
        app.alerts["Добавление навыка"].scrollViews.otherElements.buttons["Добавить"].tap()
        
        app.buttons["editButton"].tap()
    }
    
    func testWriteText() throws {
        app.tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Мои навыки").children(matching: .other).element.swipeUp()/*[[".cells.containing(.button, identifier:\"pensill\").children(matching: .other).element",".swipeUp()",".swipeRight()",".cells.containing(.button, identifier:\"editButton\").children(matching: .other).element",".cells.containing(.staticText, identifier:\"ООП\").children(matching: .other).element",".cells.containing(.staticText, identifier:\"Postman\").children(matching: .other).element",".cells.containing(.staticText, identifier:\"MVP\").children(matching: .other).element",".cells.containing(.staticText, identifier:\"Git\").children(matching: .other).element",".cells.containing(.staticText, identifier:\"Combine\").children(matching: .other).element",".cells.containing(.staticText, identifier:\"GCD\").children(matching: .other).element",".cells.containing(.staticText, identifier:\"MVC\").children(matching: .other).element",".cells.containing(.staticText, identifier:\"MVVM\").children(matching: .other).element",".cells.containing(.staticText, identifier:\"JSON API\").children(matching: .other).element",".cells.containing(.staticText, identifier:\"UIKit\").children(matching: .other).element",".cells.containing(.staticText, identifier:\"Swift\").children(matching: .other).element",".cells.containing(.staticText, identifier:\"Core Data\").children(matching: .other).element",".cells.containing(.staticText, identifier:\"Мои навыки\").children(matching: .other).element"],[[[-1,16,1],[-1,15,1],[-1,14,1],[-1,13,1],[-1,12,1],[-1,11,1],[-1,10,1],[-1,9,1],[-1,8,1],[-1,7,1],[-1,6,1],[-1,5,1],[-1,4,1],[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,1]]@END_MENU_TOKEN@*/
        app.textViews["textAboutMe"].tap()
        app.tables/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Мои навыки").children(matching: .other).element.swipeUp()/*[[".cells.containing(.button, identifier:\"pensill\").children(matching: .other).element",".swipeUp()",".swipeRight()",".cells.containing(.button, identifier:\"editButton\").children(matching: .other).element",".cells.containing(.staticText, identifier:\"ООП\").children(matching: .other).element",".cells.containing(.staticText, identifier:\"Postman\").children(matching: .other).element",".cells.containing(.staticText, identifier:\"MVP\").children(matching: .other).element",".cells.containing(.staticText, identifier:\"Git\").children(matching: .other).element",".cells.containing(.staticText, identifier:\"Combine\").children(matching: .other).element",".cells.containing(.staticText, identifier:\"GCD\").children(matching: .other).element",".cells.containing(.staticText, identifier:\"MVC\").children(matching: .other).element",".cells.containing(.staticText, identifier:\"MVVM\").children(matching: .other).element",".cells.containing(.staticText, identifier:\"JSON API\").children(matching: .other).element",".cells.containing(.staticText, identifier:\"UIKit\").children(matching: .other).element",".cells.containing(.staticText, identifier:\"Swift\").children(matching: .other).element",".cells.containing(.staticText, identifier:\"Core Data\").children(matching: .other).element",".cells.containing(.staticText, identifier:\"Мои навыки\").children(matching: .other).element"],[[[-1,16,1],[-1,15,1],[-1,14,1],[-1,13,1],[-1,12,1],[-1,11,1],[-1,10,1],[-1,9,1],[-1,8,1],[-1,7,1],[-1,6,1],[-1,5,1],[-1,4,1],[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,1]]@END_MENU_TOKEN@*/
        app.textViews["textAboutMe"].typeText("Это новый текст в этом резюме, он используется для UI тестирования")
        app.tables.cells.firstMatch.tap()
        
    }
}
