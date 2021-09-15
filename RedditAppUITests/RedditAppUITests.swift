//
//  RedditAppUITests.swift
//  RedditAppUITests
//
//  Created by Daniel Esteban Beltran Beltran on 13/09/21.
//

import XCTest

class RedditAppUITests: XCTestCase {
    func testDeleteCells() throws {
        let app = XCUIApplication()
        app.launch()
        
        let redditappPostdetailviewNavigationBar = app.navigationBars["RedditApp.PostDetailView"]
        redditappPostdetailviewNavigationBar/*@START_MENU_TOKEN@*/.buttons["BackButton"]/*[[".buttons[\" \"]",".buttons[\"BackButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let tablesQuery = app.tables
        tablesQuery.children(matching: .cell).element(boundBy: 0).firstMatch.tap()

        let popoverdismissregionElement = app/*@START_MENU_TOKEN@*/.otherElements["PopoverDismissRegion"]/*[[".otherElements[\"dismiss popup\"]",".otherElements[\"PopoverDismissRegion\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        popoverdismissregionElement.tap()
        
        redditappPostdetailviewNavigationBar/*@START_MENU_TOKEN@*/.buttons["BackButton"]/*[[".buttons[\" \"]",".buttons[\"BackButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app.navigationBars["RedditApp.PostListTableView"].buttons["Delete"].tap()
        XCTAssert(tablesQuery.children(matching: .cell).count == 0)
//        app.tables["Empty list"]/*@START_MENU_TOKEN@*/.swipeDown()/*[[".swipeDown()",".swipeLeft()"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/
    }
    
    func testSaveImageFlow() throws {
        let app = XCUIApplication()
        app.launch()
        
        let redditappPostdetailviewNavigationBar = app.navigationBars["RedditApp.PostDetailView"]
        redditappPostdetailviewNavigationBar/*@START_MENU_TOKEN@*/.buttons["BackButton"]/*[[".buttons[\" \"]",".buttons[\"BackButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let tablesQuery = app.tables
        tablesQuery.children(matching: .cell).element(boundBy: 0).firstMatch.tap()

        let popoverdismissregionElement = app/*@START_MENU_TOKEN@*/.otherElements["PopoverDismissRegion"]/*[[".otherElements[\"dismiss popup\"]",".otherElements[\"PopoverDismissRegion\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        popoverdismissregionElement.tap()
    
        app/*@START_MENU_TOKEN@*/.staticTexts["Save Image"]/*[[".buttons[\"Save Image\"].staticTexts[\"Save Image\"]",".buttons[\"saveImage\"].staticTexts[\"Save Image\"]",".staticTexts[\"Save Image\"]"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app.alerts["Saved!"].scrollViews.otherElements.buttons["OK"].tap()
    }
    
    func testPagination() throws {
        let app = XCUIApplication()
        app.launch()
        
        let redditappPostdetailviewNavigationBar = app.navigationBars["RedditApp.PostDetailView"]
        redditappPostdetailviewNavigationBar/*@START_MENU_TOKEN@*/.buttons["BackButton"]/*[[".buttons[\" \"]",".buttons[\"BackButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let tablesQuery = app.tables
        tablesQuery.children(matching: .cell).element(boundBy: 0).firstMatch.tap()

        let popoverdismissregionElement = app/*@START_MENU_TOKEN@*/.otherElements["PopoverDismissRegion"]/*[[".otherElements[\"dismiss popup\"]",".otherElements[\"PopoverDismissRegion\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        popoverdismissregionElement.tap()
        
        redditappPostdetailviewNavigationBar/*@START_MENU_TOKEN@*/.buttons["BackButton"]/*[[".buttons[\" \"]",".buttons[\"BackButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app.navigationBars["RedditApp.PostListTableView"].buttons["Delete"].tap()
        XCTAssertTrue(tablesQuery.children(matching: .cell).count == 0)
        app.tables["Empty list"]/*@START_MENU_TOKEN@*/.swipeDown()/*[[".swipeDown()",".swipeLeft()"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/
        XCTAssertTrue(tablesQuery.children(matching: .cell).count == 10)
        tablesQuery.children(matching: .cell).element(boundBy: 10).swipeUp()
        XCTAssert(tablesQuery.children(matching: .cell).count == 30)
    }
    
    func tests() throws{
        let app = XCUIApplication()
        app.launch()
        
        let redditappPostdetailviewNavigationBar = app.navigationBars["RedditApp.PostDetailView"]
        redditappPostdetailviewNavigationBar/*@START_MENU_TOKEN@*/.buttons["BackButton"]/*[[".buttons[\" \"]",".buttons[\"BackButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()

        let tablesQuery = app.tables
        tablesQuery.children(matching: .cell).element(boundBy: 0).firstMatch.tap()

        let popoverdismissregionElement = app/*@START_MENU_TOKEN@*/.otherElements["PopoverDismissRegion"]/*[[".otherElements[\"dismiss popup\"]",".otherElements[\"PopoverDismissRegion\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        popoverdismissregionElement.tap()

        XCTAssert(app.otherElements["readStatus"].exists)
    }
}


