//
//  Shuffle.swift
//  RecursiveMemoize
//
//  Created by Alexandre Lopoukhine on 18/06/2016.
//  Copyright © 2016 bluetatami. All rights reserved.
//

import Darwin

extension Collection {
    func shuffled() -> [Iterator.Element] {
        return Array(self).shuffled()
    }
}

extension MutableCollection where IndexDistance == Int {

    /// Return a copy of `self` with its elements shuffled
    func shuffled() -> Self {
        var list = self
        list.shuffle()
        return list
    }
}

extension MutableCollection where IndexDistance == Int {

    /// Shuffle the elements of `self` in-place.
    mutating func shuffle() {
        // empty and single-element collections don't shuffle
        if count < 2 { return }
        
        for i in indices {
            let maxDistance = distance(from: i, to: endIndex)
            let randomOffset = Int(arc4random_uniform(UInt32(maxDistance)))
            let j = index(i, offsetBy: randomOffset)
            guard i != j else { continue }
            swapAt(i, j)
        }
    }
}
