//
//  pmp_ui_introduceUITests.swift
//  pmp_ui_introduceUITests
//
//  Created by Student on 11/7/19.
//  Copyright © 2019 Dehtiar_Olekandr. All rights reserved.
//

import XCTest

class pmp_ui_introduceUITests: XCTestCase {
    var app: XCUIApplication!;
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app = XCUIApplication();
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    
    func testCellWithTestExists() {
        let cell = app.tables.element(boundBy: 0).cells.element(boundBy: 3);
        
        if (cell.waitForExistence(timeout: 10)) {
            let cellLabel = cell.staticTexts["Parasite"]
            XCTAssertEqual(cellLabel.exists, true, "Should be shown");
        } else {
            XCTFail("There is no expected cell");
        }
    }
    
    func testNewScreenShowRightInfoAfterTapToSecondCell() {
        let cell = app.tables.element(boundBy: 0).cells.element(boundBy: 3);
        
        if (cell.waitForExistence(timeout: 2)) {
            cell.tap();
        } else {
            XCTFail("There is no expected cell");
        }
        
        let newScreen = app.staticTexts["1817"];
        
        if (newScreen.waitForExistence(timeout: 10)) {
            let voteAverage = app.staticTexts["8.6"];
            XCTAssertEqual(voteAverage.exists, true, "Should be shown shown properly")
        } else {
            XCTFail("There is no expected cell");
        }
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

}
