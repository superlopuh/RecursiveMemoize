//
//  Rho.swift
//  RecursiveMemoize
//
//  Created by Alexandre Lopoukhine on 17/06/2016.
//  Copyright © 2016 Alexandre Lopoukhine. All rights reserved.
//

public final class RecursiveFunction<Input: Hashable, Output> {

    public let base: (Input, (Input) -> Output) -> Output

    fileprivate init(base: @escaping (Input, (Input) -> Output) -> Output) {
        self.base = base
    }

    public func callAsFunction(_ input: Input) -> Output {
        return base(input, callAsFunction)
    }

    public func memoized() -> MemoizedRecursiveFunction<Input, Output> {
        MemoizedRecursiveFunction(base: base)
    }
}

public final class MemoizedRecursiveFunction<Input: Hashable, Output> {

    public let base: (Input, (Input) -> Output) -> Output
    public private(set) var memo: [Input: Output] = [:]

    fileprivate init(base: @escaping (Input, (Input) -> Output) -> Output) {
        self.base = base
    }

    public func callAsFunction(_ input: Input) -> Output {
        if let memoized = memo[input] {
            return memoized
        } else {
            let memoized = base(input, callAsFunction)
            memo[input] = memoized
            return memoized
        }
    }
}


public func recursive<Input: Hashable, Output>(
    _ base: @escaping (Input, (Input) -> Output) -> Output
) -> RecursiveFunction<Input, Output> {
    return RecursiveFunction(base: base)
}

public final class RecursiveFunction2<Input0: Hashable, Input1: Hashable, Output> {

    public let base: (Input0, Input1, (Input0, Input1) -> Output) -> Output

    fileprivate init(
        base: @escaping (Input0, Input1, (Input0, Input1) -> Output) -> Output
    ) {
        self.base = base
    }

    public func callAsFunction(_ input0: Input0, _ input1: Input1) -> Output {
        base(input0, input1, callAsFunction)
    }

    public func memoized() -> MemoizedRecursiveFunction2<Input0, Input1, Output> {
        MemoizedRecursiveFunction2(base: base)
    }
}

public final class MemoizedRecursiveFunction2<Input0: Hashable, Input1: Hashable, Output> {

    public let base: (Input0, Input1, (Input0, Input1) -> Output) -> Output
    public private(set) var memo: [Input0: [Input1: Output]] = [:]

    fileprivate init(
        base: @escaping (Input0, Input1, (Input0, Input1) -> Output) -> Output
    ) {
        self.base = base
    }

    public func callAsFunction(_ input0: Input0, _ input1: Input1) -> Output {
        if let memoized = memo[input0]?[input1] {
            return memoized
        } else {
            let memoized = base(input0, input1, callAsFunction)
            memo[input0, default: [:]][input1] = memoized
            return memoized
        }
    }
}

public func recursive<Input0: Hashable, Input1: Hashable, Output>(
    _ base: @escaping (Input0, Input1, (Input0, Input1) -> Output) -> Output
) -> RecursiveFunction2<Input0, Input1, Output> {
    RecursiveFunction2(base: base)
}
