//
//  HomeViewUITests.swift
//  PokedexUITests
//
//  Created by Ankit Sharma on 26/10/23.
//

import XCTest

final class HomeViewUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_pokemonList_pagignation() throws {
        let app = XCUIApplication()
        let scrollViewsQuery = app.scrollViews
        let element = scrollViewsQuery.children(matching: .other).element(boundBy: 0).children(matching: .other).element
        element.swipeUp()
        
        let closeButton = scrollViewsQuery.otherElements.buttons["Close"]
        closeButton.tap()
        element.swipeUp()
        element.swipeUp()
        app.scrollViews.containing(.other, identifier:"Vertical scroll bar, 9 pages").children(matching: .other).element(boundBy: 0).children(matching: .other).element.swipeUp()
        closeButton.tap()
        element.swipeUp()
    }
    
    
    func test_pokemon_list_search() throws {
        let app = XCUIApplication()
        app.children(matching: .window).element(boundBy: 0)
            .children(matching: .other).element.children(matching: .other).element
            .children(matching: .other).element.children(matching: .other).element
            .children(matching: .other).element.children(matching: .other).element
            .children(matching: .other).element.children(matching: .other).element
            .children(matching: .other).element.children(matching: .other).element
            .children(matching: .other).element.tap()
        
        let closeImage = app.images["Close"]
        closeImage.tap()
        
        let nameOrNumberTextField = app.textFields["Name or Number"]
        nameOrNumberTextField.tap()
        nameOrNumberTextField.tap()
        app.scrollViews.containing(.other, identifier:"Vertical scroll bar, 1 page").children(matching: .other).element(boundBy: 0).children(matching: .other).element.swipeUp()
        app.scrollViews.otherElements.buttons["Close"].tap()
        closeImage.tap()
    }
    
    func test_pokemon_list_filter() throws {
        let app = XCUIApplication()
        app.buttons["filter"].tap()
        app.navigationBars["Filters"]/*@START_MENU_TOKEN@*/.buttons["Cancel"]/*[[".otherElements[\"Cancel\"].buttons[\"Cancel\"]",".buttons[\"Cancel\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    }
    
    func test_pokemon_list_detail() throws {
        let app = XCUIApplication()
        app.launch()
        
        let scrollViewsQuery = XCUIApplication().scrollViews
        let elementsQuery = scrollViewsQuery.otherElements
        elementsQuery.buttons["Bulbasaur, 001"].tap()
        
        let closeButton = elementsQuery.buttons["Close"]
        closeButton.tap()
        elementsQuery.buttons["Charmander, 004"].tap()
        closeButton.tap()
        scrollViewsQuery.children(matching: .other).element(boundBy: 0).children(matching: .other).element.swipeUp()
        elementsQuery.buttons["Kakuna, 0014"].tap()
        closeButton.tap()
        
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
