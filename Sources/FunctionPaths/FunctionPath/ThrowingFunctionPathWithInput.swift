//
//  ThrowingFunctionPathWithInput.swift
//
//
//  Created by p-x9 on 2023/11/16.
//  
//

import Foundation

@dynamicMemberLookup
public struct ThrowingFunctionPathWithInput<Root, Return> {
    public let call: (Root) throws -> Return

    // MARK: - Initializer

    public init(call: @escaping (Root) throws -> Return) {
        self.call = call
    }

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

    @_disfavoredOverload
    public func appending<AppendedReturn>(
        keyPath: KeyPath<Return, AppendedReturn>
    ) -> (Root) throws -> AppendedReturn {
        { root in
            try self.call(root)[keyPath: keyPath]
        }
    }

    public func appending<AppendedReturn>(
        keyPath: KeyPath<Return, AppendedReturn>
    ) -> ThrowingFunctionPathWithInput<Root, AppendedReturn> {
        .init { root in
            try self.call(root)[keyPath: keyPath]
        }
    }

    // MARK: - callAsFunction

    public func callAsFunction(
        _ root: Root
    ) throws -> Return {
        try call(root)
    }
}

extension ThrowingFunctionPathWithInput where Return == Root {
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
