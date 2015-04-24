//
//  RecursiveMemoize.swift
//  RecursiveMemoize
//
//  Created by Alexandre Lopoukhine on 24/04/2015.
//  Copyright (c) 2015 bluetatami. All rights reserved.
//

public protocol Initialisable {
    init()
}

public func memoizedRho<T, P: Primable, R: Initialisable where T == P.ArgType, P: Hashable>(f: T -> R, g: (P,R) -> R) -> P -> R {
    var cache = [P:R]()
    
    // Local functions cannot reference themselves
    
    // Hack found on stackoverflow
    var memoized = {(input: P) -> R in R()}
    
    memoized = {(input: P) -> R in
        if let value = cache[input] {
            return value
        } else {
            let newValue: R
            if input.isBase {
                newValue = f(input.arguments)
            } else {
                newValue = g(input, memoized(input.predecessor()))
            }
            cache[input] = newValue
            return newValue
        }
    }
    
    return memoized
}
