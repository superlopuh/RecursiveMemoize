//
//  Factorial.swift
//  RecursiveMemoize
//
//  Created by Alexandre Lopoukhine on 24/04/2015.
//  Copyright (c) 2015 bluetatami. All rights reserved.
//

let factF: () -> Int = {1}

let factG: (Int, Int) -> Int = {(pred: Int, predResult: Int) -> Int in
    return pred * predResult
}

public let factorial = rho(factF, factG)