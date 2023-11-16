//
//  FuncPath+MultiArgsSupport.swift
//
//
//  Created by p-x9 on 2023/11/16.
//  
//

import Foundation

/// Allow function paths with multiple arguments to be called as path(arg1, arg2) instead of as path((arg1, arg2)).
///
/// The following could be written using Variadic Generics,
/// but it does not seem to compile currently
/// (Apple Swift version 5.9 (swiftlang-5.9.0.128.108 clang-1500.0.40.1))
///
///```swift
/// public func callAsFunction<each T>(
///     _ input: repeat @escaping @autoclosure () -> (each T)
/// ) -> (Root) -> Return where Input == (repeat each T){
///     { root in
///         let inputs = (repeat (each input)())
///         return call(root)(inputs) // ❌
///     }
/// }
///```
extension FunctionPath {

    // MARK: 2 args
    @_disfavoredOverload
    public func callAsFunction<In1, In2>(
        _ arg1: @escaping @autoclosure () -> In1,
        _ arg2: @escaping @autoclosure () -> In2
    ) -> (Root) -> Return where Input == (In1, In2) {
        { root in
            call(root)((arg1(), arg2()))
        }
    }

    public func callAsFunction<In1, In2>(
        _ arg1: @escaping @autoclosure () -> In1,
        _ arg2: @escaping @autoclosure () -> In2
    ) -> FunctionPathWithInput<Root, Return> where Input == (In1, In2) {
        .init(
            call: call,
            input: (arg1(), arg2())
        )
    }

    // MARK: 3 args
    @_disfavoredOverload
    public func callAsFunction<In1, In2, In3>(
        _ arg1: @escaping @autoclosure () -> In1,
        _ arg2: @escaping @autoclosure () -> In2,
        _ arg3: @escaping @autoclosure () -> In3
    ) -> (Root) -> Return where Input == (In1, In2, In3) {
        { root in
            call(root)((arg1(), arg2(), arg3()))
        }
    }

    public func callAsFunction<In1, In2, In3>(
        _ arg1: @escaping @autoclosure () -> In1,
        _ arg2: @escaping @autoclosure () -> In2,
        _ arg3: @escaping @autoclosure () -> In3
    ) -> FunctionPathWithInput<Root, Return> where Input == (In1, In2, In3) {
        .init(
            call: call,
            input: (arg1(), arg2(), arg3())
        )
    }

    // MARK: 4 args
    @_disfavoredOverload
    public func callAsFunction<In1, In2, In3, In4>(
        _ arg1: @escaping @autoclosure () -> In1,
        _ arg2: @escaping @autoclosure () -> In2,
        _ arg3: @escaping @autoclosure () -> In3,
        _ arg4: @escaping @autoclosure () -> In4
    ) -> (Root) -> Return where Input == (In1, In2, In3, In4) {
        { root in
            call(root)((arg1(), arg2(), arg3(), arg4()))
        }
    }

    public func callAsFunction<In1, In2, In3, In4>(
        _ arg1: @escaping @autoclosure () -> In1,
        _ arg2: @escaping @autoclosure () -> In2,
        _ arg3: @escaping @autoclosure () -> In3,
        _ arg4: @escaping @autoclosure () -> In4
    ) -> FunctionPathWithInput<Root, Return> where Input == (In1, In2, In3, In4) {
        .init(
            call: call,
            input: (arg1(), arg2(), arg3(), arg4())
        )
    }

    // MARK: 5 args
    @_disfavoredOverload
    public func callAsFunction<In1, In2, In3, In4, In5>(
        _ arg1: @escaping @autoclosure () -> In1,
        _ arg2: @escaping @autoclosure () -> In2,
        _ arg3: @escaping @autoclosure () -> In3,
        _ arg4: @escaping @autoclosure () -> In4,
        _ arg5: @escaping @autoclosure () -> In5
    ) -> (Root) -> Return where Input == (In1, In2, In3, In4, In5) {
        { root in
            call(root)((arg1(), arg2(), arg3(), arg4(), arg5()))
        }
    }

    public func callAsFunction<In1, In2, In3, In4, In5>(
        _ arg1: @escaping @autoclosure () -> In1,
        _ arg2: @escaping @autoclosure () -> In2,
        _ arg3: @escaping @autoclosure () -> In3,
        _ arg4: @escaping @autoclosure () -> In4,
        _ arg5: @escaping @autoclosure () -> In5
    ) -> FunctionPathWithInput<Root, Return> where Input == (In1, In2, In3, In4, In5) {
        .init(
            call: call,
            input: (arg1(), arg2(), arg3(), arg4(), arg5())
        )
    }
}
