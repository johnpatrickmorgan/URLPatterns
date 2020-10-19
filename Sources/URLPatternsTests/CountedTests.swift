import XCTest
import URLPatterns

class CountedTests: XCTestCase {

    func testCountedInstantiation() throws {
        let counted = Counted([1, 2, 3])
        XCTAssert(counted == .n3(1, 2, 3))
    }
}
