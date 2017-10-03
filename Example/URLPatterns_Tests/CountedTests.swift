//
//  URLPatterns_Tests.swift
//  URLPatterns_Tests
//
//  Created by John Morgan on 03/10/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
import URLPatterns

class CountedTests: XCTestCase {
    
    func testLosslessConversion() {

        let examples: [[Int]] = (0...20).map({ Array(0..<$0) })

        for example in examples {
            let converted = Counted(example).elements
            XCTAssertEqual(example, converted)
        }
    }
}
