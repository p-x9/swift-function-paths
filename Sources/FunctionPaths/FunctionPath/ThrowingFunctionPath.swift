//
//  ThrowingFunctionPath.swift
//
//
//  Created by p-x9 on 2023/11/16.
//  
//

import Foundation

@dynamicMemberLookup
public struct ThrowingFunctionPath<Root, Input, Return> {
    public let call: (Root) -> (Input) throws -> Return

    // MARK: - Initializer

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

    @_disfavoredOverload
    public func callAsFunction(
        _ input: @escaping @autoclosure () -> Input
    ) -> (Root) throws -> Return {
        { root in
            try call(root)(input())
        }
    }

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
