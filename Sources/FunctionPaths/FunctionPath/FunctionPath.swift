//
//  FunctionPath.swift
//
//
//  Created by p-x9 on 2023/11/15.
//  
//

import Foundation

@dynamicMemberLookup
public struct FunctionPath<Root, Input, Return> {
    public let call: (Root) -> (Input) -> Return

    // MARK: - Initializer

    public init(
        call: @escaping (Root) -> (Input) -> Return
    ) {
        self.call = call
    }

    // MARK: - subscript

    @_disfavoredOverload
    public subscript<AppendedReturn>(
        dynamicMember keyPath: KeyPath<Return, AppendedReturn>
    ) -> (Root) -> (Input) -> AppendedReturn {
        appending(keyPath: keyPath)
    }

    public subscript<AppendedReturn>(
        dynamicMember keyPath: KeyPath<Return, AppendedReturn>
    ) -> FunctionPath<Root, Input, AppendedReturn> {
        appending(keyPath: keyPath)
    }

    // MARK: - appending

    public func appending<AppendedReturn>(
        path: FunctionPathWithInput<Return, AppendedReturn>
    ) -> FunctionPath<Root, Input, AppendedReturn> {
        .init(
            call: { root in
                { input in
                    path.call(call(root)(input))
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
    ) -> AsyncFunctionPath<Root, Input, AppendedReturn> {
        .init(
            call: { root in
                { input in
                    await path.call(call(root)(input))
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
    ) -> (Root) -> (Input) -> AppendedReturn {
        { root in
            { input in
                self.call(root)(input)[keyPath: keyPath]
            }
        }
    }

    public func appending<AppendedReturn>(
        keyPath: KeyPath<Return, AppendedReturn>
    ) -> FunctionPath<Root, Input, AppendedReturn> {
        .init { root in
            { input in
                self.call(root)(input)[keyPath: keyPath]
            }
        }
    }

    // MARK: - callAsFunction

    @_disfavoredOverload
    public func callAsFunction(
        _ input: @escaping @autoclosure () -> Input
    ) -> (Root) -> Return {
        { root in
            call(root)(input())
        }
    }

    public func callAsFunction(
        _ input: @escaping @autoclosure () -> Input
    ) -> FunctionPathWithInput<Root, Return> {
        .init(
            call: call,
            input: input()
        )
    }
}

extension FunctionPath where Return == Root, Input == Void {
    public static var `self`: Self {
        .init()
    }

    public init() {
        self.init(call: { root in return { _ in root}})
    }
}

// MARK: - CustomDebugStringConvertible
extension FunctionPath: CustomDebugStringConvertible {
    public var debugDescription: String {
        "FunctionPath<\(Root.self), \(Input.self), \(Return.self)>"
    }
}
