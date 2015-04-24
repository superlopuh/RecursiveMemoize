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
}

extension NChooseKPair: BackwardIndexType {
    func predecessor() -> NChooseKPair {
        return NChooseKPair(n: n - 1, k: k - 1)
    }
}

extension NChooseKPair: Primable {
    typealias ArgType = Int
    
    var arguments: ArgType {return self.n}
    
    var isBase: Bool {
        return self.k == 0
    }
}

extension NChooseKPair: Hashable {
    var hashValue: Int {
        let mult = Int.multiplyWithOverflow(n.hashValue, 3).0
        return Int.addWithOverflow(mult, k.hashValue).0
    }
}

func ==(lhs: NChooseKPair, rhs: NChooseKPair) -> Bool {
    return (lhs.k == rhs.k) && (lhs.n == rhs.n)
}

func chooseF(n: Int) -> Int {
    return 1
}

func chooseG(pair: NChooseKPair, predResult: Int) -> Int {
    return pair.n * predResult / pair.k
}

let memoNChooseK = memoizedRho(chooseF, chooseG)

public func nChooseK(n: Int, k: Int) -> Int {
    // n choose k == n choose (k-1), only want to compute one of those
    return memoNChooseK(NChooseKPair(n: n, k: min(k, n - k)))
}
