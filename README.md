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

```swift
// Standard recursive definition of factorial
public func fact0(_ n: Int) -> Int {
    return n < 2 ? 1 : n * fact0(n - 1)
}

// Standard memoized factorial
let memoFact0 = memoize(fact0)

// Explicitly recursive factorial definition
let fact1 = recursive { n, fact in n < 2 ? 1 : n * fact(n - 1) }

// Recursively memoized factorial
let memoFact1 = fact1.memoized()
```

Usage:

```swift
memoFact0(15) // 14 multiplications
memoFact0(15) // 0 multiplications, one lookup
memoFact0(14) // 13 multiplications

memoFact1(15) // 14 multiplications
memoFact1(15) // 0 multiplications, one lookup
memoFact1(14) // 0 multiplications, one lookup
```
