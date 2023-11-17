//
//  AsyncThrowingFunctionPath.swift
//
//
//  Created by p-x9 on 2023/11/17.
//  
//

import Foundation

@dynamicMemberLookup
public struct AsyncThrowingFunctionPath<Root, Input, Return> {
    public let call: (Root) -> (Input) async throws -> Return

    // MARK: - Initializer

    public init(
        call: @escaping (Root) -> (Input) async throws -> Return
    ) {
        self.call = call
    }

    // MARK: - subscript

    @_disfavoredOverload
    public subscript<AppendedReturn>(
        dynamicMember keyPath: KeyPath<Return, AppendedReturn>
    ) -> (Root) -> (Input) async throws -> AppendedReturn {
        appending(keyPath: keyPath)
    }

    public subscript<AppendedReturn>(
        dynamicMember keyPath: KeyPath<Return, AppendedReturn>
    ) -> AsyncThrowingFunctionPath<Root, Input, AppendedReturn> {
        appending(keyPath: keyPath)
    }

    // MARK: - appending
    @_disfavoredOverload
    public func appending<AppendedReturn>(
        keyPath: KeyPath<Return, AppendedReturn>
    ) -> (Root) -> (Input) async throws -> AppendedReturn {
        { root in
            { input in
                try await self.call(root)(input)[keyPath: keyPath]
            }
        }
    }

    public func appending<AppendedReturn>(
        keyPath: KeyPath<Return, AppendedReturn>
    ) -> AsyncThrowingFunctionPath<Root, Input, AppendedReturn> {
        .init { root in
            { input in
                try await self.call(root)(input)[keyPath: keyPath]
            }
        }
    }

    // MARK: - callAsFunction

    @_disfavoredOverload
    public func callAsFunction(
        _ input: @escaping @autoclosure () -> Input
    ) -> (Root) async throws -> Return {
        { root in
            try await call(root)(input())
        }
    }

//    public func callAsFunction(
//        _ input: @escaping @autoclosure () -> Input
//    ) -> AsyncThrowingFunctionPathWithInput<Root, Return> {
//        .init(
//            call: call,
//            input: input()
//        )
//    }
}

extension AsyncThrowingFunctionPath where Return == Root, Input == Void {
    public static var `self`: Self {
        .init()
    }

    public init() {
        self.init(call: { root in return { _ in root}})
    }
}

// MARK: - CustomDebugStringConvertible
extension AsyncThrowingFunctionPath: CustomDebugStringConvertible {
    public var debugDescription: String {
        "AsyncThrowingFunctionPath<\(Root.self), \(Input.self), \(Return.self)>"
    }
}
