//
//  FactorialTests.swift
//  RecursiveMemoize
//
//  Created by Alexandre Lopoukhine on 17/06/2016.
//  Copyright © 2016 Alexandre Lopoukhine. All rights reserved.
//

import XCTest
import RecursiveMemoize

private let numberOfRuns = 1000
private let range = 0..<20

private let factorial = recursive { n, fact in n == 0 ? 1 : n * fact(n-1) }

class FactorialTests: XCTestCase {
    
    func testFactorial() {
        XCTAssertEqual(1, factorial(0))
        XCTAssertEqual(2, factorial(2))
        XCTAssertEqual(6, factorial(3))
        XCTAssertEqual(24, factorial(4))
        
        XCTAssertEqual(3628800, factorial(10))
        XCTAssertEqual(362880, factorial(9))
    }
    
    func testMemoizedFactorial() {
        let memoizedFactorial = factorial.memoized()
        XCTAssertEqual(1, memoizedFactorial(0))
        XCTAssertEqual(2, memoizedFactorial(2))
        XCTAssertEqual(6, memoizedFactorial(3))
        XCTAssertEqual(24, memoizedFactorial(4))
        
        XCTAssertEqual(3628800, memoizedFactorial(10))
        XCTAssertEqual(362880, memoizedFactorial(9))
    }

    func testMemo() throws {
        let fact = factorial.memoized()

        XCTAssertEqual(fact(0), 1)
        XCTAssertEqual(fact.memo, [0: 1])

        XCTAssertEqual(fact(1), 1)
        XCTAssertEqual(fact.memo, [0: 1, 1: 1])

        XCTAssertEqual(fact(3), 6)
        XCTAssertEqual(fact.memo, [0: 1, 1: 1, 2: 2, 3: 6])

        XCTAssertEqual(fact(5), 120)
        XCTAssertEqual(fact.memo, [0: 1, 1: 1, 2: 2, 3: 6, 4: 24, 5: 120])
    }
    
    func testPerformance() {
        self.measure {
            for _ in 0..<numberOfRuns {
                let compute = factorial
                for k in range.shuffled() {
                    _ = compute(k)
                }
            }
        }
    }
    
    func testMemoizedPerformance() {
        self.measure {
            for _ in 0..<numberOfRuns {
                let compute = factorial.memoized()
                for k in range.shuffled() {
                    _ = compute(k)
                }
            }
        }
    }
}
