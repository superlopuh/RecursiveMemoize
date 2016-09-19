//
//  FactorialTests.swift
//  RecursiveMemoize
//
//  Created by Alexandre Lopoukhine on 17/06/2016.
//  Copyright © 2016 bluetatami. All rights reserved.
//

import XCTest
import RecursiveMemoize

private let numberOfRuns = 1000
private let range = 0..<20

private let factorial = Rho(
    isBase: { $0 == 0 },
    decrement: { $0 - 1 },
    baseFunction: { _ in 1 },
    recursionFunction: *
)

class FactorialTests: XCTestCase {
    
    func testFactorial() {
        XCTAssertEqual(1, factorial.compute(0))
        XCTAssertEqual(2, factorial.compute(2))
        XCTAssertEqual(6, factorial.compute(3))
        XCTAssertEqual(24, factorial.compute(4))
        
        XCTAssertEqual(3628800, factorial.compute(10))
        XCTAssertEqual(362880, factorial.compute(9))
    }
    
    func testMemoizedFactorial() {
        let memoizedCompute = factorial.getMemoizedCompute()
        XCTAssertEqual(1, memoizedCompute(0))
        XCTAssertEqual(2, memoizedCompute(2))
        XCTAssertEqual(6, memoizedCompute(3))
        XCTAssertEqual(24, memoizedCompute(4))
        
        XCTAssertEqual(3628800, memoizedCompute(10))
        XCTAssertEqual(362880, memoizedCompute(9))
    }
    
    func testPerformance() {
        self.measure {
            for _ in 0..<numberOfRuns {
                let compute = factorial.compute
                for k in range.shuffled() {
                    _ = compute(k)
                }
            }
        }
    }
    
    func testMemoizedPerformance() {
        self.measure {
            for _ in 0..<numberOfRuns {
                let compute = factorial.getMemoizedCompute()
                for k in range.shuffled() {
                    _ = compute(k)
                }
            }
        }
    }
}
