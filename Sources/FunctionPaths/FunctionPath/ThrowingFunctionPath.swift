//
//  ThrowingFunctionPath.swift
//
//
//  Created by p-x9 on 2023/11/16.
//  
//

import Foundation

/// The function handled may throw an error, but it is not an asynchronous function.
///
/// ``ThrowingFuncPath`` is available as an alias.
///
@dynamicMemberLookup
public struct ThrowingFunctionPath<Root, Input, Return> {

    /// target function
    public let call: (Root) -> (Input) throws -> Return

    // MARK: - Initializer

    /// Default initializer
    /// - Parameter call: target function
    public init(
        call: @escaping (Root) -> (Input) throws -> Return
    ) {
        self.call = call
    }

    // MARK: - subscript

    @_disfavoredOverload
    public subscript<AppendedReturn>(
        dynamicMember keyPath: KeyPath<Return, AppendedReturn>
    ) -> (Root) -> (Input) throws -> AppendedReturn {
        appending(keyPath: keyPath)
    }

    public subscript<AppendedReturn>(
        dynamicMember keyPath: KeyPath<Return, AppendedReturn>
    ) -> ThrowingFunctionPath<Root, Input, AppendedReturn> {
        appending(keyPath: keyPath)
    }

    // MARK: - appending

    /// Appends a transformation to the current `ThrowingFunctionPath` using another `FunctionPathWithInput`.
    ///
    /// This method allows for the composition of two function paths, effectively chaining their behavior.
    /// The transformation applied by the provided `FunctionPathWithInput` is executed after the current function path’s operation.
    ///
    /// The returned `ThrowingFunctionPath` has the same `Root` and `Input`
    /// types as the original but with an `AppendedReturn` type that reflects the return type of the
    /// provided `FunctionPathWithInput`.
    ///
    /// - Parameter path: `FunctionPathWithInput` instance to be appended
    /// - Returns: A new `ThrowingFunctionPath` instance that represents the combination of the current function path and the appended transformation.
    ///
    public func appending<AppendedReturn>(
        path: FunctionPathWithInput<Return, AppendedReturn>
    ) -> ThrowingFunctionPath<Root, Input, AppendedReturn> {
        .init(
            call: { root in
                { input in
                    try path.call(call(root)(input))
                }
            }
        )
    }

    /// Appends a transformation to the current `ThrowingFunctionPath` using another `ThrowingFunctionPathWithInput`.
    ///
    /// This method allows for the composition of two function paths, effectively chaining their behavior.
    /// The transformation applied by the provided `ThrowingFunctionPathWithInput` is executed after the current function path’s operation.
    ///
    /// The returned `ThrowingFunctionPath` has the same `Root` and `Input`
    /// types as the original but with an `AppendedReturn` type that reflects the return type of the
    /// provided `ThrowingFunctionPathWithInput`.
    ///
    /// - Parameter path: `ThrowingFunctionPathWithInput` instance to be appended
    /// - Returns: A new `ThrowingFunctionPath` instance that represents the combination of the current function path and the appended transformation.
    ///
    public func appending<AppendedReturn>(
        path: ThrowingFunctionPathWithInput<Return, AppendedReturn>
    ) -> ThrowingFunctionPath<Root, Input, AppendedReturn> {
        .init(
            call: { root in
                { input in
                    try path.call(call(root)(input))
                }
            }
        )
    }

    /// Appends a transformation to the current `ThrowingFunctionPath` using another `AsyncFunctionPathWithInput`.
    ///
    /// This method allows for the composition of two function paths, effectively chaining their behavior.
    /// The transformation applied by the provided `AsyncFunctionPathWithInput` is executed after the current function path’s operation.
    ///
    /// The returned `AsyncThrowingFunctionPath` has the same `Root` and `Input`
    /// types as the original but with an `AppendedReturn` type that reflects the return type of the
    /// provided `AsyncFunctionPathWithInput`.
    ///
    /// - Parameter path: `AsyncFunctionPathWithInput` instance to be appended
    /// - Returns: A new `AsyncThrowingFunctionPath` instance that represents the combination of the current function path and the appended transformation.
    ///
    public func appending<AppendedReturn>(
        path: AsyncFunctionPathWithInput<Return, AppendedReturn>
    ) -> AsyncThrowingFunctionPath<Root, Input, AppendedReturn> {
        .init(
            call: { root in
                { input in
                    try await path.call(call(root)(input))
                }
            }
        )
    }

    /// Appends a transformation to the current `ThrowingFunctionPath` using another `AsyncThrowingFunctionPathWithInput`.
    ///
    /// This method allows for the composition of two function paths, effectively chaining their behavior.
    /// The transformation applied by the provided `AsyncThrowingFunctionPathWithInput` is executed after the current function path’s operation.
    ///
    /// The returned `AsyncThrowingFunctionPath` has the same `Root` and `Input`
    /// types as the original but with an `AppendedReturn` type that reflects the return type of the
    /// provided `AsyncThrowingFunctionPathWithInput`.
    ///
    /// - Parameter path: `AsyncThrowingFunctionPathWithInput` instance to be appended
    /// - Returns: A new `AsyncThrowingFunctionPath` instance that represents the combination of the current function path and the appended transformation.
    ///
    public func appending<AppendedReturn>(
        path: AsyncThrowingFunctionPathWithInput<Return, AppendedReturn>
    ) -> AsyncThrowingFunctionPath<Root, Input, AppendedReturn> {
        .init(
            call: { root in
                { input in
                    try await path.call(call(root)(input))
                }
            }
        )
    }

    /// Appends a transformation to the current `ThrowingFunctionPath` using a `KeyPath`.
    ///
    /// - Parameter keyPath: A `KeyPath` from the `Return` type of the current function path to the desired `AppendedReturn` type.
    ///   This keyPath specifies the property to be extracted or transformed from the `Return` type.
    ///
    /// - Returns: A new function of type `(Root) -> (Input) throws -> AppendedReturn`.
    /// This function, when called, executes the original function path and then applies the keyPath to extract or transform its return value.
    ///
    @_disfavoredOverload
    public func appending<AppendedReturn>(
        keyPath: KeyPath<Return, AppendedReturn>
    ) -> (Root) -> (Input) throws -> AppendedReturn {
        { root in
            { input in
                try self.call(root)(input)[keyPath: keyPath]
            }
        }
    }

    /// Appends a transformation to the current `ThrowingFunctionPath` using a `KeyPath`.
    ///
    /// This version of the `appending` method creates a new `ThrowingFunctionPath` instance, extending the original function's behavior by applying the specified `KeyPath`.
    ///
    /// - Parameter keyPath: A `KeyPath` from the `Return` type of the current function path to the desired `AppendedReturn` type.
    ///   This keyPath specifies the property to be extracted or transformed from the `Return` type.
    ///
    /// - Returns: A new `ThrowingFunctionPath<Root, Input, AppendedReturn>` instance.
    ///   This function path will execute the original function and then apply the `keyPath` to the result, effectively transforming the return type to `AppendedReturn`.
    ///
    public func appending<AppendedReturn>(
        keyPath: KeyPath<Return, AppendedReturn>
    ) -> ThrowingFunctionPath<Root, Input, AppendedReturn> {
        .init { root in
            { input in
                try self.call(root)(input)[keyPath: keyPath]
            }
        }
    }

    // MARK: - callAsFunction

    /// Captures the input arguments of a function and turns this path into a closure with `Root` as input
    ///
    /// - Parameter input: Input value of the function indicated by this path.
    ///     With `@autoclosure` attribute, this input is evaluated at function execution time
    ///
    /// - Returns: A closure of type `(Root) throws -> Return`.
    ///     When invoked with a `Root` instance, this closure
    ///   executes the original function path with the provided `input`.
    ///
    @_disfavoredOverload
    public func callAsFunction(
        _ input: @escaping @autoclosure () -> Input
    ) -> (Root) throws -> Return {
        { root in
            try call(root)(input())
        }
    }

    /// Captures the input arguments of a function and turns this path into a instance of `ThrowingFunctionPathWithInput`
    ///
    /// - Parameter input: Input value of the function indicated by this path.
    ///     With `@autoclosure` attribute, this input is evaluated at function execution time
    ///
    /// - Returns: A instance of `ThrowingFunctionPathWithInput`.
    ///
    public func callAsFunction(
        _ input: @escaping @autoclosure () -> Input
    ) -> ThrowingFunctionPathWithInput<Root, Return> {
        .init(
            call: call,
            input: input()
        )
    }
}

extension ThrowingFunctionPath where Return == Root, Input == Void {
    /// Function Path that returns root itself
    public static var `self`: Self {
        .init()
    }

    public init() {
        self.init(call: { root in return { _ in root}})
    }
}

// MARK: - CustomDebugStringConvertible
extension ThrowingFunctionPath: CustomDebugStringConvertible {
    public var debugDescription: String {
        "ThrowingFunctionPath<\(Root.self), \(Input.self), \(Return.self)>"
    }
}
