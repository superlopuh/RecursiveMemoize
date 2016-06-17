//
//  NChooseK.swift
//  RecursiveMemoize
//
//  Created by Alexandre Lopoukhine on 24/04/2015.
//  Copyright (c) 2015 bluetatami. All rights reserved.
//

struct NChooseKPair {
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

func ==(lhs: NChooseKPair, rhs: NChooseKPair) -> Bool {
    return (lhs.k == rhs.k) && (lhs.n == rhs.n)
}

func chooseG(pair: NChooseKPair, predResult: Int) -> Int {
    return pair.n * predResult / pair.k
}

let memoNChooseK = memoizedRho(
    f: { _ in 1 },
    g: chooseG,
    decrement: { pair in NChooseKPair(pair.n - 1, pair.k - 1) },
    isBase: { $0.n == 0 }
)

public func nChooseK(n: Int, k: Int) -> Int {
    // n choose k == n choose (k-1), only want to compute one of those
    return memoNChooseK(NChooseKPair(n, min(k, n - k)))
}
