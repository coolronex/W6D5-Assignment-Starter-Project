//
//  w6d5_ui_performance_testingUITests.swift
//  w6d5-ui-performance-testingUITests
//
//  Created by Aaron Chong on 2/23/18.
//  Copyright © 2018 Roland. All rights reserved.
//

import XCTest

class w6d5_ui_performance_testingUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        app = XCUIApplication()
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAddMeal() {
    
        addNewMeal(withMealName: "burger", numberOfCalories: "300")
    }
    
    func testDeleteMeal() {
        
        deleteMeal(withMealName: "burger", numberOfCalories: "300")
    }
    
    func testShowMealDetail() {
        
        showMealDetail(withMealName: "burger", numberOfCalories: "300")
        let labelElement = app.staticTexts["detailViewControllerLabel"]
        
        XCTAssertEqual(labelElement.label, "burger - 300")
    }

    
    
    private func addNewMeal(withMealName name: String, numberOfCalories calories: String) {
        
        app.navigationBars["Master"].buttons["Add"].tap()
        let addAMealAlert = app.alerts["Add a Meal"]
        let collectionViewsQuery = addAMealAlert.collectionViews
        collectionViewsQuery.children(matching: .other).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .textField).element.typeText(name)
        
        let textField = collectionViewsQuery.children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .textField).element
        textField.tap()
        textField.tap()
        textField.typeText(calories)
        addAMealAlert.buttons["Ok"].tap()
    }
    
    private func deleteMeal(withMealName name: String, numberOfCalories calories: String) {
        
        let tablesQuery = app.tables.cells
        let staticText = tablesQuery.children(matching: .cell).element(boundBy: 0).staticTexts["\(name) - \(calories)"]
        if staticText.exists {
            staticText.swipeLeft()
            tablesQuery.buttons["Delete"].tap()
        }
    }
    
    private func showMealDetail(withMealName name: String, numberOfCalories calories: String) {
        
        XCUIApplication().tables.cells.staticTexts["\(name) - \(calories)"].tap()
    }
    
    
}
