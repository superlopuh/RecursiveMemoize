//
//  Factorial.swift
//  RecursiveMemoize
//
//  Created by Alexandre Lopoukhine on 24/04/2015.
//  Copyright (c) 2015 bluetatami. All rights reserved.
//

public let factorial = rho(
    f: { _ in 1},
    g: *,
    decrement: { $0 - 1 },
    isBase: { $0 == 0 }
)
