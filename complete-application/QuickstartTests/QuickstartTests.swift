import XCTest

final class QuickstartTests: XCTestCase {
    private var app: XCUIApplication!

    override func setUpWithError() throws {
        app = XCUIApplication()

        continueAfterFailure = false

        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    private func confirmLoginAlert(_ app: XCUIApplication) {
        var alertPresent = false

        let predicate = NSPredicate { evaluatedObject, _ in
            let application = evaluatedObject as? XCUIApplication
            application?.tap()
            return alertPresent
        }

        let alertMonitor = addUIInterruptionMonitor(withDescription: "Login Alert") { alert -> Bool in
            alert.buttons["Continue"].tap()
            alertPresent = true
            return true
        }

        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: app)
        wait(for: [expectation], timeout: 120)
        removeUIInterruptionMonitor(alertMonitor)
    }

    @MainActor
    func testExample() throws {
        let loginButton = app.buttons["Login"]
        XCTAssertTrue(loginButton.exists)
        loginButton.tap()

        confirmLoginAlert(app)

        let emailField = app.textFields["Email"]
        let passwordField = app.secureTextFields["Password"]
        let submitButton = app.buttons["Submit"]

        XCTAssertTrue(emailField.waitForExistence(timeout: 60))
        XCTAssertTrue(passwordField.waitForExistence(timeout: 60))
        XCTAssertTrue(submitButton.waitForExistence(timeout: 60))

        emailField.tap()
        emailField.typeText("richard@example.com")

        passwordField.tap()
        passwordField.typeText("password")

        submitButton.tap()

        // Check that Welcome message is displayed
        let welcomeText = app.staticTexts["Welcome Richard Hendricks"]

        XCTAssertTrue(welcomeText.waitForExistence(timeout: 60))

        // Check that Log out button is displayed
        let logoutButton = app.buttons["Log out"]
        XCTAssertTrue(logoutButton.exists)
        logoutButton.tap()

        confirmLoginAlert(app)

        XCTAssertTrue(loginButton.waitForExistence(timeout: 60))
    }
}
