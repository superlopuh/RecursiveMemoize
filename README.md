# RecursiveMemoize
An implementation of recursive memoization in Swift.

The motivation for this was a realisation that the standard memoization technique in swift is not very good at memoizing recursive functions.

This is what a typical swift memoize function looks like:

```swift
func memoize<T: Hashable, U>(fn : T -> U) -> T -> U {
    var cache = [T:U]()
    return {(val : T) -> U in
        if let value = cache[val] {
            return value
        } else {
            let newValue = fn(val)
            cache[val] = newValue
            return newValue
        }
    }
}
```

If you were to memoize a factorial function, and then compute 15!, and subsequently 14!, even though 14! would have been computed within the first function call, the result would not be stored in the cache.

If the function can be represented as a [primitive recursive function](http://en.wikipedia.org/wiki/Primitive_recursive_function), then the memoization can be done at each step of the recursion.

So here's what I came up with:

The argument iterated on must conform to these protocols:
```swift
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
```

Primitive recursion without memoization:
```swift
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
```

Primitive recursion with memoization:
```swift
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
```
