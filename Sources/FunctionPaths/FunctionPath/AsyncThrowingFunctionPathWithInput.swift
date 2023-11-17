//
//  AsyncThrowingFunctionPathWithInput.swift
//
//
//  Created by p-x9 on 2023/11/17.
//  
//

import Foundation

@dynamicMemberLookup
public struct AsyncThrowingFunctionPathWithInput<Root, Return> {
    public let call: (Root) async throws -> Return

    // MARK: - Initializer

    public init(call: @escaping (Root) async throws -> Return) {
        self.call = call
    }

    public init<Input>(
        call: @escaping (Root) -> (Input) async throws -> Return,
        input: @escaping @autoclosure () -> Input
    ) {
        self.call = { root in
            try await call(root)(input())
        }
    }

    // MARK: - subscript

    @_disfavoredOverload
    public subscript<AppendedReturn>(
        dynamicMember keyPath: KeyPath<Return, AppendedReturn>
    ) -> (Root) async throws -> AppendedReturn {
        appending(keyPath: keyPath)
    }

    public subscript<AppendedReturn>(
        dynamicMember keyPath: KeyPath<Return, AppendedReturn>
    ) -> AsyncThrowingFunctionPathWithInput<Root, AppendedReturn> {
        appending(keyPath: keyPath)
    }

    // MARK: - appending

    public func appending<Input, AppendedReturn>(
        path: FunctionPath<Return, Input, AppendedReturn>
    ) -> AsyncThrowingFunctionPath<Root, Input, AppendedReturn> {
        .init(
            call: { root in
                { input in
                    try await path.call(call(root))(input)
                }
            }
        )
    }

    public func appending<Input, AppendedReturn>(
        path: ThrowingFunctionPath<Return, Input, AppendedReturn>
    ) -> AsyncThrowingFunctionPath<Root, Input, AppendedReturn> {
        .init(
            call: { root in
                { input in
                    try await path.call(call(root))(input)
                }
            }
        )
    }

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

    public func appending<AppendedReturn>(
        path: FunctionPathWithInput<Return, AppendedReturn>
    ) -> AsyncThrowingFunctionPathWithInput<Root, AppendedReturn> {
        .init(
            call: { root in
                try await path.call(call(root))
            }
        )
    }

    public func appending<AppendedReturn>(
        path: ThrowingFunctionPathWithInput<Return, AppendedReturn>
    ) -> AsyncThrowingFunctionPathWithInput<Root, AppendedReturn> {
        .init(
            call: { root in
                try await path.call(call(root))
            }
        )
    }

    public func appending<AppendedReturn>(
        path: AsyncFunctionPathWithInput<Return, AppendedReturn>
    ) -> AsyncThrowingFunctionPathWithInput<Root, AppendedReturn> {
        .init(
            call: { root in
                try await path.call(call(root))
            }
        )
    }

    public func appending<AppendedReturn>(
        path: AsyncThrowingFunctionPathWithInput<Return, AppendedReturn>
    ) -> AsyncThrowingFunctionPathWithInput<Root, AppendedReturn> {
        .init(
            call: { root in
                try await path.call(call(root))
            }
        )
    }

    @_disfavoredOverload
    public func appending<AppendedReturn>(
        keyPath: KeyPath<Return, AppendedReturn>
    ) -> (Root) async throws -> AppendedReturn {
        { root in
            try await self.call(root)[keyPath: keyPath]
        }
    }

    public func appending<AppendedReturn>(
        keyPath: KeyPath<Return, AppendedReturn>
    ) -> AsyncThrowingFunctionPathWithInput<Root, AppendedReturn> {
        .init { root in
            try await self.call(root)[keyPath: keyPath]
        }
    }

    // MARK: - callAsFunction

    public func callAsFunction(
        _ root: Root
    ) async throws -> Return {
        try await call(root)
    }
}

extension AsyncThrowingFunctionPathWithInput where Return == Root {
    public static var `self`: Self {
        .init()
    }

    public init() {
        self.init(call: { root in return root})
    }
}

// MARK: - CustomDebugStringConvertible
extension AsyncThrowingFunctionPathWithInput: CustomDebugStringConvertible {
    public var debugDescription: String {
        "AsyncThrowingFunctionPathWithInput<\(Root.self), \(Return.self)>"
    }
}
