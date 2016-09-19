//
//  NChooseKTest.swift
//  RecursiveMemoize
//
//  Created by Alexandre Lopoukhine on 18/06/2016.
//  Copyright © 2016 bluetatami. All rights reserved.
//

import XCTest
import RecursiveMemoize

private struct NChooseKPair {
    var n: Int
    var k: Int
    
    init(_ n: Int, _ k: Int) {
        self.n = n
        self.k = k
    }
}

extension NChooseKPair: Hashable {
    var hashValue: Int {
        return n.hashValue &* 3 &+ k.hashValue
    }
}

private func ==(lhs: NChooseKPair, rhs: NChooseKPair) -> Bool {
    return (lhs.k == rhs.k) && (lhs.n == rhs.n)
}

private let nChooseK = Rho(
    isBase: { $0.n == 0 },
    decrement: { pair in NChooseKPair(pair.n - 1, pair.k - 1) },
    baseFunction: { _ in 1 },
    recursionFunction: { (pair: NChooseKPair, predResult: Int) in 0 == pair.k ? 1 : pair.n * predResult / pair.k }
)

private let numberOfRuns = 1000
private let range = 0...20
private let pairs = range.flatMap { n in (0...n).map { k in NChooseKPair(n,k)} }

class NChooseKTest: XCTestCase {
    
    func testFactorial() {
        let compute = nChooseK.compute
        XCTAssertEqual(1, compute(NChooseKPair(2,2)))
        XCTAssertEqual(3, compute(NChooseKPair(3,2)))
        XCTAssertEqual(6, compute(NChooseKPair(4,2)))
        XCTAssertEqual(10, compute(NChooseKPair(5,2)))
        
        XCTAssertEqual(45, compute(NChooseKPair(10,2)))
        XCTAssertEqual(36, compute(NChooseKPair(9,2)))
    }
    
    func testMemoizedFactorial() {
        let compute = nChooseK.getMemoizedCompute()
        XCTAssertEqual(1, compute(NChooseKPair(2,2)))
        XCTAssertEqual(3, compute(NChooseKPair(3,2)))
        XCTAssertEqual(6, compute(NChooseKPair(4,2)))
        XCTAssertEqual(10, compute(NChooseKPair(5,2)))
        
        XCTAssertEqual(45, compute(NChooseKPair(10,2)))
        XCTAssertEqual(36, compute(NChooseKPair(9,2)))
    }
    
    func testPerformance() {
        let compute = nChooseK.compute
        self.measure {
            for _ in 0..<numberOfRuns {
                for pair in pairs.shuffled() {
                    _ = compute(pair)
                }
            }
        }
    }
    
    func testMemoizedPerformance() {
        let compute = nChooseK.getMemoizedCompute()
        self.measure {
            for _ in 0..<numberOfRuns {
                for pair in pairs.shuffled() {
                    _ = compute(pair)
                }
            }
        }
    }
}
