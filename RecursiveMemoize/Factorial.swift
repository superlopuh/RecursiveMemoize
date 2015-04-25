//
//  Factorial.swift
//  RecursiveMemoize
//
//  Created by Alexandre Lopoukhine on 24/04/2015.
//  Copyright (c) 2015 bluetatami. All rights reserved.
//

let factF: () -> Int = {1}

let factG: (Int, Int) -> Int = {(input: Int, predResult: Int) -> Int in
    return input * predResult
}

public let factorial = rho(factF, factG)
