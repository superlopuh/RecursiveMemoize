//
//  Primable.swift
//  RecursiveMemoize
//
//  Created by Alexandre Lopoukhine on 24/04/2015.
//  Copyright (c) 2015 bluetatami. All rights reserved.
//

public protocol BackwardIndexType {
    func predecessor() -> Self
}

public protocol Primable: Equatable, BackwardIndexType {
    typealias ArgType
    
    var arguments: ArgType {get}
    
    var isBase: Bool {get}
}
