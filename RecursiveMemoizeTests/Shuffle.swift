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

extension MutableCollection where Index: Strideable, Index.Stride == Int {
    /// Return a copy of `self` with its elements shuffled
    func shuffled() -> Self {
        var list = self
        list.shuffle()
        return list
    }
}

extension MutableCollection where Index: Strideable, Index.Stride == Int {
    /// Shuffle the elements of `self` in-place.
    mutating func shuffle() {
        // empty and single-element collections don't shuffle
        if count < 2 { return }
        
        for i in startIndex..<endIndex - 1 {
            let j = Int(arc4random_uniform(UInt32(endIndex - i))) + i
            guard i != j else { continue }
            swap(&self[i], &self[j])
        }
    }
}
