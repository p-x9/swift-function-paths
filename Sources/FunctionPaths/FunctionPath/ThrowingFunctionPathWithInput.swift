//
//  ThrowingFunctionPathWithInput.swift
//
//
//  Created by p-x9 on 2023/11/16.
//  
//

import Foundation

/// The function handled may throw an error, but it is not an asynchronous function.
///
/// ``ThrowingFuncPathWithInput`` is available as an alias.
///
@dynamicMemberLookup
public struct ThrowingFunctionPathWithInput<Root, Return> {

    /// target function
    public let call: (Root) throws -> Return

    // MARK: - Initializer

    /// Default initializer
    /// - Parameter call: target function
    ///     This closure should be capturing input values.
    public init(call: @escaping (Root) throws -> Return) {
        self.call = call
    }

    /// Default initializer
    /// - Parameters:
    ///   - call: target function
    ///   - input: Input value of the function indicated by this path.
    ///     With `@autoclosure` attribute, this input is evaluated at function execution time
    public init<Input>(
        call: @escaping (Root) -> (Input) throws -> Return,
        input: @escaping @autoclosure () -> Input
    ) {
        self.call = { root in
            try call(root)(input())
        }
    }

    // MARK: - subscript

    @_disfavoredOverload
    public subscript<AppendedReturn>(
        dynamicMember keyPath: KeyPath<Return, AppendedReturn>
    ) -> (Root) throws -> AppendedReturn {
        appending(keyPath: keyPath)
    }

    public subscript<AppendedReturn>(
        dynamicMember keyPath: KeyPath<Return, AppendedReturn>
    ) -> ThrowingFunctionPathWithInput<Root, AppendedReturn> {
        appending(keyPath: keyPath)
    }

    // MARK: - appending

    /// Appends a transformation to the current `ThrowingFunctionPathWithInput` using another `FunctionPath`.
    ///
    /// This method allows for the composition of two function paths, effectively chaining their behavior.
    /// The transformation applied by the provided `FunctionPath` is executed after the current function path’s operation.
    ///
    /// The returned `ThrowingFunctionPath` has the same `Root` and `Input`
    /// types as the original but with an `AppendedReturn` type that reflects the return type of the
    /// provided `ThrowingFunctionPath`.
    ///
    /// - Parameter path: `FunctionPath` instance to be appended
    /// - Returns: A new `ThrowingFunctionPath` instance that represents the combination of the current function path and the appended transformation.
    ///
    public func appending<Input, AppendedReturn>(
        path: FunctionPath<Return, Input, AppendedReturn>
    ) -> ThrowingFunctionPath<Root, Input, AppendedReturn> {
        .init(
            call: { root in
                { input in
                    try path.call(call(root))(input)
                }
            }
        )
    }

    /// Appends a transformation to the current `ThrowingFunctionPathWithInput` using another `ThrowingFunctionPath`.
    ///
    /// This method allows for the composition of two function paths, effectively chaining their behavior.
    /// The transformation applied by the provided `ThrowingFunctionPath` is executed after the current function path’s operation.
    ///
    /// The returned `ThrowingFunctionPath` has the same `Root` and `Input`
    /// types as the original but with an `AppendedReturn` type that reflects the return type of the
    /// provided `ThrowingFunctionPath`.
    ///
    /// - Parameter path: `ThrowingFunctionPath` instance to be appended
    /// - Returns: A new `ThrowingFunctionPath` instance that represents the combination of the current function path and the appended transformation.
    ///
    public func appending<Input, AppendedReturn>(
        path: ThrowingFunctionPath<Return, Input, AppendedReturn>
    ) -> ThrowingFunctionPath<Root, Input, AppendedReturn> {
        .init(
            call: { root in
                { input in
                    try path.call(call(root))(input)
                }
            }
        )
    }

    /// Appends a transformation to the current `ThrowingFunctionPathWithInput` using another `AsyncFunctionPath`.
    ///
    /// This method allows for the composition of two function paths, effectively chaining their behavior.
    /// The transformation applied by the provided `AsyncFunctionPath` is executed after the current function path’s operation.
    ///
    /// The returned `AsyncThrowingFunctionPath` has the same `Root` and `Input`
    /// types as the original but with an `AppendedReturn` type that reflects the return type of the
    /// provided `AsyncFunctionPath`.
    ///
    /// - Parameter path: `AsyncFunctionPath` instance to be appended
    /// - Returns: A new `AsyncThrowingFunctionPath` instance that represents the combination of the current function path and the appended transformation.
    ///
    public func appending<Input, AppendedReturn>(
        path: AsyncFunctionPath<Return, Input, AppendedReturn>
    ) -> AsyncThrowingFunctionPath<Root, Input, AppendedReturn> {
        .init(
            call: { root in
                { input in
                    try await path.call(call(root))(input)
                }
            }
        )
    }

    /// Appends a transformation to the current `ThrowingFunctionPathWithInput` using another `AsyncThrowingFunctionPath`.
    ///
    /// This method allows for the composition of two function paths, effectively chaining their behavior.
    /// The transformation applied by the provided `AsyncThrowingFunctionPath` is executed after the current function path’s operation.
    ///
    /// The returned `AsyncThrowingFunctionPath` has the same `Root` and `Input`
    /// types as the original but with an `AppendedReturn` type that reflects the return type of the
    /// provided `AsyncThrowingFunctionPath`.
    ///
    /// - Parameter path: `AsyncThrowingFunctionPath` instance to be appended
    /// - Returns: A new `AsyncThrowingFunctionPath` instance that represents the combination of the current function path and the appended transformation.
    ///
    public func appending<Input, AppendedReturn>(
        path: AsyncThrowingFunctionPath<Return, Input, AppendedReturn>
    ) -> AsyncThrowingFunctionPath<Root, Input, AppendedReturn> {
        .init(
            call: { root in
                { input in
                    try await path.call(call(root))(input)
                }
            }
        )
    }

    /// Appends a transformation to the current `ThrowingFunctionPathWithInput` using another `FunctionPathWithInput`.
    ///
    /// This method allows for the composition of two function paths, effectively chaining their behavior.
    /// The transformation applied by the provided `FunctionPathWithInput` is executed after the current function path’s operation.
    ///
    /// The returned `ThrowingFunctionPathWithInput` has the same `Root` and `Input`
    /// types as the original but with an `AppendedReturn` type that reflects the return type of the
    /// provided `FunctionPathWithInput`.
    ///
    /// - Parameter path: `FunctionPathWithInput` instance to be appended
    /// - Returns: A new `ThrowingFunctionPathWithInput` instance that represents the combination of the current function path and the appended transformation.
    ///
    public func appending<AppendedReturn>(
        path: FunctionPathWithInput<Return, AppendedReturn>
    ) -> ThrowingFunctionPathWithInput<Root, AppendedReturn> {
        .init(
            call: { root in
                try path.call(call(root))
            }
        )
    }

    /// Appends a transformation to the current `ThrowingFunctionPathWithInput` using another `ThrowingFunctionPathWithInput`.
    ///
    /// This method allows for the composition of two function paths, effectively chaining their behavior.
    /// The transformation applied by the provided `ThrowingFunctionPathWithInput` is executed after the current function path’s operation.
    ///
    /// The returned `ThrowingFunctionPathWithInput` has the same `Root` and `Input`
    /// types as the original but with an `AppendedReturn` type that reflects the return type of the
    /// provided `ThrowingFunctionPathWithInput`.
    ///
    /// - Parameter path: `ThrowingFunctionPathWithInput` instance to be appended
    /// - Returns: A new `ThrowingFunctionPathWithInput` instance that represents the combination of the current function path and the appended transformation.
    ///
    public func appending<AppendedReturn>(
        path: ThrowingFunctionPathWithInput<Return, AppendedReturn>
    ) -> ThrowingFunctionPathWithInput<Root, AppendedReturn> {
        .init(
            call: { root in
                try path.call(call(root))
            }
        )
    }

    /// Appends a transformation to the current `ThrowingFunctionPathWithInput` using another `AsyncFunctionPathWithInput`.
    ///
    /// This method allows for the composition of two function paths, effectively chaining their behavior.
    /// The transformation applied by the provided `AsyncFunctionPathWithInput` is executed after the current function path’s operation.
    ///
    /// The returned `AsyncThrowingFunctionPathWithInput` has the same `Root` and `Input`
    /// types as the original but with an `AppendedReturn` type that reflects the return type of the
    /// provided `AsyncFunctionPathWithInput`.
    ///
    /// - Parameter path: `AsyncFunctionPathWithInput` instance to be appended
    /// - Returns: A new `AsyncThrowingFunctionPathWithInput` instance that represents the combination of the current function path and the appended transformation.
    ///
    public func appending<AppendedReturn>(
        path: AsyncFunctionPathWithInput<Return, AppendedReturn>
    ) -> AsyncThrowingFunctionPathWithInput<Root, AppendedReturn> {
        .init(
            call: { root in
                try await path.call(call(root))
            }
        )
    }

    /// Appends a transformation to the current `ThrowingFunctionPathWithInput` using another `AsyncThrowingFunctionPathWithInput`.
    ///
    /// This method allows for the composition of two function paths, effectively chaining their behavior.
    /// The transformation applied by the provided `AsyncThrowingFunctionPathWithInput` is executed after the current function path’s operation.
    ///
    /// The returned `AsyncThrowingFunctionPathWithInput` has the same `Root` and `Input`
    /// types as the original but with an `AppendedReturn` type that reflects the return type of the
    /// provided `AsyncThrowingFunctionPathWithInput`.
    ///
    /// - Parameter path: `AsyncThrowingFunctionPathWithInput` instance to be appended
    /// - Returns: A new `AsyncThrowingFunctionPathWithInput` instance that represents the combination of the current function path and the appended transformation.
    ///
    public func appending<AppendedReturn>(
        path: AsyncThrowingFunctionPathWithInput<Return, AppendedReturn>
    ) -> AsyncThrowingFunctionPathWithInput<Root, AppendedReturn> {
        .init(
            call: { root in
                try await path.call(call(root))
            }
        )
    }

    /// Appends a transformation to the current `ThrowingFunctionPathWithInput` using a `KeyPath`.
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
    ) -> (Root) throws -> AppendedReturn {
        { root in
            try self.call(root)[keyPath: keyPath]
        }
    }

    /// Appends a transformation to the current `ThrowingFunctionPathWithInput` using a `KeyPath`.
    ///
    /// This version of the `appending` method creates a new `ThrowingFunctionPathWithInput` instance, extending the original function's behavior by applying the specified `KeyPath`.
    ///
    /// - Parameter keyPath: A `KeyPath` from the `Return` type of the current function path to the desired `AppendedReturn` type.
    ///   This keyPath specifies the property to be extracted or transformed from the `Return` type.
    ///
    /// - Returns: A new `ThrowingFunctionPathWithInput<Root, AppendedReturn>` instance.
    ///   This function path will execute the original function and then apply the `keyPath` to the result, effectively transforming the return type to `AppendedReturn`.
    ///
    public func appending<AppendedReturn>(
        keyPath: KeyPath<Return, AppendedReturn>
    ) -> ThrowingFunctionPathWithInput<Root, AppendedReturn> {
        .init { root in
            try self.call(root)[keyPath: keyPath]
        }
    }

    // MARK: - callAsFunction

    /// Execute function
    /// - Parameter root: Target for executing the function
    /// - Returns: Return value of function
    public func callAsFunction(
        _ root: Root
    ) throws -> Return {
        try call(root)
    }
}

extension ThrowingFunctionPathWithInput where Return == Root {
    /// Function Path that returns root itself
    public static var `self`: Self {
        .init()
    }

    public init() {
        self.init(call: { root in return root})
    }
}

// MARK: - CustomDebugStringConvertible
extension ThrowingFunctionPathWithInput: CustomDebugStringConvertible {
    public var debugDescription: String {
        "ThrowingFunctionPathWithInput<\(Root.self), \(Return.self)>"
    }
}
