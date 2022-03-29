//
//  FibonacciTests.swift
//  RecursiveMemoize
//
//  Created by Alexandre Lopoukhine on 29/03/2022.
//  Copyright © 2022 Alexandre Lopoukhine. All rights reserved.
//

import XCTest
@testable import RecursiveMemoize

final class FibonacciTests: XCTestCase {

    func testFibonacci() throws {
        let fib = recursive { n, fib in n < 2 ? 1 : fib(n-1) + fib(n-2) }.memoized()

        XCTAssertEqual(fib(0), 1)
        XCTAssertEqual(fib.memo, [0: 1])

        XCTAssertEqual(fib(1), 1)
        XCTAssertEqual(fib.memo, [0: 1, 1: 1])

        XCTAssertEqual(fib(3), 3)
        XCTAssertEqual(fib.memo, [0: 1, 1: 1, 2: 2, 3: 3])

        XCTAssertEqual(fib(5), 8)
        XCTAssertEqual(fib.memo, [0: 1, 1: 1, 2: 2, 3: 3, 4: 5, 5: 8])
    }
}
