//
//  Rho.swift
//  RecursiveMemoize
//
//  Created by Alexandre Lopoukhine on 17/06/2016.
//  Copyright © 2016 bluetatami. All rights reserved.
//

public struct Rho<Input, Output> {
    public let isBase: Input -> Bool
    public let decrement: Input -> Input
    public let baseFunction: Input -> Output
    public let recursionFunction: (Input, Output) -> Output
    
    public init(isBase: Input -> Bool, decrement: Input -> Input, baseFunction: Input -> Output, recursionFunction: (Input, Output) -> Output) {
        self.isBase = isBase
        self.decrement = decrement
        self.baseFunction = baseFunction
        self.recursionFunction = recursionFunction
    }
}

extension Rho {
    public func compute(input: Input) -> Output {
        if isBase(input) {
            return baseFunction(input)
        } else {
            let recursiveResult = compute(decrement(input))
            return recursionFunction(input, recursiveResult)
        }
    }
}

extension Rho where Input: Hashable {
    public func getMemoizedCompute() -> Input -> Output {
        var memo = [Input:Output]()
        
        func memoizedCompute(input: Input) -> Output {
            if let value = memo[input] {
                return value
            } else {
                let newValue: Output
                if isBase(input) {
                    newValue = baseFunction(input)
                } else {
                    newValue = recursionFunction(input, memoizedCompute(decrement(input)))
                }
                memo[input] = newValue
                return newValue
            }
        }
        
        return memoizedCompute
    }
}
