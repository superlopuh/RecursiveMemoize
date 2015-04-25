//
//  PrimitiveRecursion.swift
//  RecursiveMemoize
//
//  Created by Alexandre Lopoukhine on 24/04/2015.
//  Copyright (c) 2015 bluetatami. All rights reserved.
//

public func rho<T, P: Primable,R where T == P.ArgType>(f: T -> R, g: (P,R) -> R)(_ input: P) -> R {
    if input.isBase {
        return f(input.arguments)
    } else {
        return g(input, rho(f, g)(input.predecessor()))
    }
}
