//
//  NChooseKTest.swift
//  RecursiveMemoize
//
//  Created by Alexandre Lopoukhine on 18/06/2016.
//  Copyright © 2016 Alexandre Lopoukhine. All rights reserved.
//

import XCTest
import RecursiveMemoize

private let nChooseK = recursive { (n: Int, k: Int, nChooseK: ((Int, Int) -> Int)) in
    let myK = min(k, n-k)
    guard myK > 0 else { return 1 }
    return n * nChooseK(n-1, myK-1) / myK
}

private let numberOfRuns = 1000
private let range = 0...20
private let pairs = range.flatMap { n in (0...n).map { k in (n, k)} }

class NChooseKTest: XCTestCase {
    
    func testFactorial() {
        let compute = nChooseK
        XCTAssertEqual(1, compute(2, 2))
        XCTAssertEqual(3, compute(3, 2))
        XCTAssertEqual(6, compute(4, 2))
        XCTAssertEqual(10, compute(5, 2))
        
        XCTAssertEqual(45, compute(10, 2))
        XCTAssertEqual(36, compute(9, 2))
    }
    
    func testMemoizedFactorial() {
        let compute = nChooseK.memoized()
        XCTAssertEqual(1, compute(2, 2))
        XCTAssertEqual(3, compute(3, 2))
        XCTAssertEqual(6, compute(4, 2))
        XCTAssertEqual(10, compute(5, 2))

        XCTAssertEqual(45, compute(10, 2))
        XCTAssertEqual(36, compute(9, 2))
    }

    func testMemo() throws {
        let compute = nChooseK.memoized()

        XCTAssertEqual(compute(0, 0), 1)
        XCTAssertEqual(compute.memo, [0: [0: 1]])

        XCTAssertEqual(compute(1, 0), 1)
        XCTAssertEqual(compute.memo, [0: [0: 1], 1: [0: 1]])

        XCTAssertEqual(compute(3, 2), 3)
        XCTAssertEqual(compute.memo, [
            0: [0: 1],
            1: [0: 1],
            2: [0: 1],
            3: [2: 3],
        ])

        XCTAssertEqual(compute(3, 2), 3)
        XCTAssertEqual(compute.memo, [
            0: [0: 1],
            1: [0: 1],
            2: [0: 1],
            3: [2: 3],
        ])

        XCTAssertEqual(compute(3, 1), 3)
        XCTAssertEqual(compute.memo, [
            0: [0: 1],
            1: [0: 1],
            2: [0: 1],
            3: [1: 3, 2: 3],
        ])

        XCTAssertEqual(compute(5, 3), 10)
        XCTAssertEqual(compute.memo, [
            0: [0: 1],
            1: [0: 1],
            2: [0: 1],
            3: [0: 1, 1: 3, 2: 3],
            4: [1: 4],
            5: [3: 10],
        ])
    }
    
    func testPerformance() {
        let compute = nChooseK
        self.measure {
            for _ in 0..<numberOfRuns {
                for (n, k) in pairs.shuffled() {
                    _ = compute(n, k)
                }
            }
        }
    }
    
    func testMemoizedPerformance() {
        let compute = nChooseK.memoized()
        self.measure {
            for _ in 0..<numberOfRuns {
                for (n, k) in pairs.shuffled() {
                    _ = compute(n, k)
                }
            }
        }
    }
}
