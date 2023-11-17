//
//  AsyncFunctionPathWithInput.swift
//
//
//  Created by p-x9 on 2023/11/17.
//  
//

import Foundation

@dynamicMemberLookup
public struct AsyncFunctionPathWithInput<Root, Return> {
    public let call: (Root) async -> Return

    // MARK: - Initializer

    public init(call: @escaping (Root) async -> Return) {
        self.call = call
    }

    public init<Input>(
        call: @escaping (Root) -> (Input) async -> Return,
        input: @escaping @autoclosure () -> Input
    ) {
        self.call = { root in
            await call(root)(input())
        }
    }

    // MARK: - subscript

    @_disfavoredOverload
    public subscript<AppendedReturn>(
        dynamicMember keyPath: KeyPath<Return, AppendedReturn>
    ) -> (Root) async -> AppendedReturn {
        appending(keyPath: keyPath)
    }

    public subscript<AppendedReturn>(
        dynamicMember keyPath: KeyPath<Return, AppendedReturn>
    ) -> AsyncFunctionPathWithInput<Root, AppendedReturn> {
        appending(keyPath: keyPath)
    }

    // MARK: - appending

    public func appending<Input, AppendedReturn>(
        path: FunctionPath<Return, Input, AppendedReturn>
    ) -> AsyncFunctionPath<Root, Input, AppendedReturn> {
        .init(
            call: { root in
                { input in
                    await path.call(call(root))(input)
                }
            }
        )
    }

    public func appending<Input, AppendedReturn>(
        path: AsyncFunctionPath<Return, Input, AppendedReturn>
    ) -> AsyncFunctionPath<Root, Input, AppendedReturn> {
        .init(
            call: { root in
                { input in
                    await path.call(call(root))(input)
                }
            }
        )
    }

//    public func appending<Input, AppendedReturn>(
//        path: ThrowingFunctionPath<Return, Input, AppendedReturn>
//    ) -> ThrowingFunctionPath<Root, Input, AppendedReturn> {
//        .init(
//            call: { root in
//                { input in
//                    try path.call(call(root))(input)
//                }
//            }
//        )
//    }

    @_disfavoredOverload
    public func appending<AppendedReturn>(
        keyPath: KeyPath<Return, AppendedReturn>
    ) -> (Root) async -> AppendedReturn {
        { root in
            await self.call(root)[keyPath: keyPath]
        }
    }

    public func appending<AppendedReturn>(
        keyPath: KeyPath<Return, AppendedReturn>
    ) -> AsyncFunctionPathWithInput<Root, AppendedReturn> {
        .init { root in
            await self.call(root)[keyPath: keyPath]
        }
    }

    // MARK: - callAsFunction

    public func callAsFunction(
        _ root: Root
    ) async -> Return {
        await call(root)
    }
}

extension AsyncFunctionPathWithInput where Return == Root {
    public static var `self`: Self {
        .init()
    }

    public init() {
        self.init(call: { root in return root})
    }
}

// MARK: - CustomDebugStringConvertible
extension AsyncFunctionPathWithInput: CustomDebugStringConvertible {
    public var debugDescription: String {
        "AsyncFunctionPathWithInput<\(Root.self), \(Return.self)>"
    }
}
