//
//  IntExtension.swift
//  RecursiveMemoize
//
//  Created by Alexandre Lopoukhine on 24/04/2015.
//  Copyright (c) 2015 bluetatami. All rights reserved.
//

extension Int: Primable {
    typealias ArgType = ()
    
    public var arguments: () {return ()}
    
    public var isBase: Bool {
        return self == 0
    }
}

extension Int: Initialisable {
}

