//
//  RecursiveMemoize.swift
//  RecursiveMemoize
//
//  Created by Alexandre Lopoukhine on 24/04/2015.
//  Copyright (c) 2015 bluetatami. All rights reserved.
//

public func memoizedRho<P: Hashable,R>(f f: P -> R, g: (P, R) -> R, decrement: P -> P, isBase: P -> Bool) -> P -> R {
    var cache: [P:R] = [:]
    
    func memoized(input: P) -> R {
        if let value = cache[input] {
            return value
        } else {
            let newValue: R
            if isBase(input) {
                newValue = f(input)
            } else {
                newValue = g(input, memoized(decrement(input)))
            }
            cache[input] = newValue
            return newValue
        }
    }
    
    return memoized
}
