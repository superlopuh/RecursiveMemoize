//
//  PrimitiveRecursion.swift
//  RecursiveMemoize
//
//  Created by Alexandre Lopoukhine on 24/04/2015.
//  Copyright (c) 2015 bluetatami. All rights reserved.
//

public func rho<P,R>(f f: P -> R, g: (P, R) -> R, decrement: P -> P, isBase: P -> Bool) -> P -> R {
    return { input in
        if isBase(input) {
            return f(input)
        } else {
            return g(input, rho(f: f, g: g, decrement: decrement, isBase: isBase)(decrement(input)))
        }
    }
}
