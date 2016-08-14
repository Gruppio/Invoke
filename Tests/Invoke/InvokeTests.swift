import XCTest
@testable import Invoke

class InvokeTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(Invoke().text, "Hello, World!")
    }


    static var allTests : [(String, (InvokeTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
