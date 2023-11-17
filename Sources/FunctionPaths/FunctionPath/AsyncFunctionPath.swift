//
//  AsyncFunctionPath.swift
//
//
//  Created by p-x9 on 2023/11/17.
//  
//

import Foundation

@dynamicMemberLookup
public struct AsyncFunctionPath<Root, Input, Return> {
    public let call: (Root) -> (Input) async -> Return

    // MARK: - Initializer

    public init(
        call: @escaping (Root) -> (Input) async -> Return
    ) {
        self.call = call
    }

    // MARK: - subscript

    @_disfavoredOverload
    public subscript<AppendedReturn>(
        dynamicMember keyPath: KeyPath<Return, AppendedReturn>
    ) -> (Root) -> (Input) async -> AppendedReturn {
        appending(keyPath: keyPath)
    }

    public subscript<AppendedReturn>(
        dynamicMember keyPath: KeyPath<Return, AppendedReturn>
    ) -> AsyncFunctionPath<Root, Input, AppendedReturn> {
        appending(keyPath: keyPath)
    }

    // MARK: - appending
    @_disfavoredOverload
    public func appending<AppendedReturn>(
        keyPath: KeyPath<Return, AppendedReturn>
    ) -> (Root) -> (Input) async -> AppendedReturn {
        { root in
            { input in
                await self.call(root)(input)[keyPath: keyPath]
            }
        }
    }

    public func appending<AppendedReturn>(
        keyPath: KeyPath<Return, AppendedReturn>
    ) -> AsyncFunctionPath<Root, Input, AppendedReturn> {
        .init { root in
            { input in
                await self.call(root)(input)[keyPath: keyPath]
            }
        }
    }

    // MARK: - callAsFunction

    @_disfavoredOverload
    public func callAsFunction(
        _ input: @escaping @autoclosure () -> Input
    ) -> (Root) async -> Return {
        { root in
            await call(root)(input())
        }
    }

    public func callAsFunction(
        _ input: @escaping @autoclosure () -> Input
    ) -> AsyncFunctionPathWithInput<Root, Return> {
        .init(
            call: call,
            input: input()
        )
    }
}

extension AsyncFunctionPath where Return == Root, Input == Void {
    public static var `self`: Self {
        .init()
    }

    public init() {
        self.init(call: { root in return { _ in root}})
    }
}

// MARK: - CustomDebugStringConvertible
extension AsyncFunctionPath: CustomDebugStringConvertible {
    public var debugDescription: String {
        "AsyncFunctionPath<\(Root.self), \(Input.self), \(Return.self)>"
    }
}
