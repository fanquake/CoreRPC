import XCTest
@testable import CoreRPC

final class CoreRPCTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(CoreRPC().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
