//
//  PazaramaUITests.swift
//  PazaramaUITests
//
//  Created by utku on 5.11.2022.
//

import XCTest

final class PazaramaUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    func testLogin() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.textFields["Email"].tap()
        
        let passwordSecureTextField = app.secureTextFields["Password"]
        passwordSecureTextField.tap()
        passwordSecureTextField.tap()
        app.buttons["Log In"].tap()
    }
    
    
    func testCart() {
        
        let app = XCUIApplication()
        app.launch()
        app/*@START_MENU_TOKEN@*/.collectionViews.containing(.other, identifier:"Vertical scroll bar, 2 pages")/*[[".scrollViews",".collectionViews.containing(.other, identifier:\"Horizontal scroll bar, 2 pages\")",".collectionViews.containing(.other, identifier:\"Vertical scroll bar, 2 pages\")"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.cells.otherElements.containing(.staticText, identifier:"Mens Cotton Jacket").buttons["add to shopping cart"].tap()
        app/*@START_MENU_TOKEN@*/.collectionViews/*[[".scrollViews.collectionViews",".collectionViews"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.cells.otherElements.containing(.staticText, identifier:"Mens Casual Slim Fit").element.tap()
        app.buttons["Add to Cart"].tap()
        app.navigationBars["Pazarama.DetailView"].buttons["Back"].tap()
        
        let shoppingCartButton = app.tabBars["Tab Bar"].buttons["Shopping Cart"]
        shoppingCartButton.tap()
        
        let table = app.windows.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .table).element
        table.swipeDown()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Mens Casual Slim Fit"]/*[[".cells.staticTexts[\"Mens Casual Slim Fit\"]",".staticTexts[\"Mens Casual Slim Fit\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeDown()
        shoppingCartButton.tap()
        table.swipeDown()
        app.buttons["Buy"].tap()
        app.alerts["Buy"].scrollViews.otherElements.buttons["Yes"].tap()
                
    }
    
    func testLogout() {
        
        let app = XCUIApplication()
        app.launch()
        app.tabBars["Tab Bar"].buttons["Profile"].tap()
        app.navigationBars["Profile"].buttons["rectangle.portrait.and.arrow.right"].tap()
        
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
