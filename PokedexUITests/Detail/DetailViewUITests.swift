//
//  DetailViewUITests.swift
//  PokedexUITests
//
//  Created by Ankit Sharma on 26/10/23.
//

// swiftlint:disable all
import XCTest

final class DetailViewUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_detail_view() throws {
        let app = XCUIApplication()
        app.launch()
        
        let scrollViewsQuery = XCUIApplication().scrollViews
        let elementsQuery = scrollViewsQuery.otherElements
        elementsQuery.buttons["Metapod, 0011"].tap()
        
        let metapodElement = scrollViewsQuery.otherElements.containing(.staticText, identifier:"METAPOD").element
        metapodElement.swipeUp()
        metapodElement/*@START_MENU_TOKEN@*/.press(forDuration: 0.5);/*[[".tap()",".press(forDuration: 0.5);"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        elementsQuery.scrollViews.otherElements.staticTexts["ground"].swipeLeft()
        elementsQuery.scrollViews.containing(.other, identifier:"Horizontal scroll bar, 2 pages").children(matching: .other).element(boundBy: 0).children(matching: .other).element.swipeLeft()
        metapodElement.swipeUp()
        scrollViewsQuery.otherElements.containing(.staticText, identifier:"METAPOD").children(matching: .scrollView).element(boundBy: 2).swipeLeft()
        metapodElement.swipeDown()
        metapodElement.swipeDown()
        elementsQuery.buttons["Close"].tap()
        
    }
    
    func test_detail_view_readMore_button_action() throws {
        let app = XCUIApplication()
        let elementsQuery = app.scrollViews.otherElements
        let metapod0011Button = elementsQuery.buttons["Metapod, 0011"]
        metapod0011Button.tap()
        metapod0011Button.tap()
        
        let readMoreButton = elementsQuery.buttons["Read more"]
        readMoreButton.tap()
        
        let popoverdismissregionElement = app.windows.children(matching: .other)
            .element(boundBy: 1)
        /*@START_MENU_TOKEN@*/.otherElements["PopoverDismissRegion"]/*[[".otherElements[\"dismiss popup\"]",".otherElements[\"PopoverDismissRegion\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        popoverdismissregionElement.swipeUp()
        readMoreButton.tap()
        elementsQuery.staticTexts["This POKéMON is vulnerable to attack while its\nshell is soft, exposing its weak and tender body.This POKéMON is vulnerable to attack while its\nshell is soft, exposing its weak and tender body.Hardens its shell to protect itself. However, a large\nimpact may cause it to pop out of its shell.Inside the shell, it is soft and weak as it pre­\npares to evolve. It stays motion­ less in the shell.It prepares for evolution by har­ dening its shell\nas much as possi­ ble to protect its soft body.This is its pre- evolved form. At this stage, it can\nonly harden, so it remains motionless to avoid attack.The shell covering this POKéMON’s body is as hard as an iron slab. METAPOD does not move very much.\nIt stays still because it is preparing its soft innards for evolution inside the hard shell.The shell covering this POKéMON’s body is as hard as an iron slab. METAPOD does not move very much.\nIt stays still because it is preparing its soft innards for evolution inside the hard shell.Its shell is as hard as an iron slab. A METAPOD does not move very much because it is preparing its soft innards for evolution inside the shell.Even though it is encased in a sturdy shell, the body inside is tender. It can’t withstand a harsh attack.This POKéMON is vulnerable to attack while its shell is soft, exposing its weak and tender body.A steel-hard shell protects its tender body. It quietly endures hardships while awaiting evolution.A steel-hard shell protects its tender body. It quietly endures hardships while awaiting evolution.A steel-hard shell protects its tender body. It quietly endures hardships while awaiting evolution.Inside the shell, it is soft and weak as it prepares to evolve. It stays motionless in the shell.It prepares for evolution by hardening its shell as much as possible to protect its soft body.A steel-hard shell protects its tender body. It quietly endures hardships while awaiting evolution.A steel-hard shell protects its tender body. It quietly endures hardships while awaiting evolution.A steel-hard shell protects its tender body. It quietly endures hardships while awaiting evolution.A steel-hard shell protects its tender body. It quietly endures hardships while awaiting evolution.A steel-hard shell protects its tender body. It quietly endures hardships while awaiting evolution.This Pokémon is vulnerable to attack while its shell is soft, exposing its weak and tender body.The shell covering this Pokémon’s body is as hard as an iron slab. Metapod does not move very much. It stays still because it is preparing its soft innards for evolution inside the hard shell.The shell covering this Pokémon’s body is as hard as an iron slab. Metapod does not move very much. It stays still because it is preparing its soft innards for evolution inside the hard shell.Its shell is filled with its soft innards. It doesn’t move much because of the risk it might carelessly spill its innards out.Its shell is hard, but it’s still just a bug shell. It’s been known to break, so intense battles with it should be avoided.Its shell is filled with a thick liquid. All of the cells throughout its body are being rebuilt in preparation for evolution.Its hard shell doesn’t crack a bit even if Pikipek pecks at it, but it will tip over, spilling out its insides.Hardens its shell to protect itself. However, a large impact may cause it to pop out of its shell.Hardens its shell to protect itself. However, a large impact may cause it to pop out of its shell.It is waiting for the moment to evolve. At this stage, it can only harden, so it remains motionless to avoid attack.Even though it is encased in a sturdy shell, the body inside is tender. It can’t withstand a harsh attack."].swipeUp()
        readMoreButton.tap()
        popoverdismissregionElement.swipeUp()
        elementsQuery.buttons["Close"].tap()
                
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
