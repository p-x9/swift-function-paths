//
//  File.swift
//  
//
//  Created by p-x9 on 2023/11/15.
//  
//

import Foundation

@dynamicMemberLookup
public struct FunctionPathWithInput<Root, Return> {
    public let call: (Root) -> Return

    // MARK: - Initializer

    public init(call: @escaping (Root) -> Return) {
        self.call = call
    }

    public init<Input>(
        call: @escaping (Root) -> (Input) -> Return,
        input: @escaping @autoclosure () -> Input
    ) {
        self.call = { root in
            call(root)(input())
        }
    }

    // MARK: - subscript

    @_disfavoredOverload
    public subscript<AppendedReturn>(
        dynamicMember keyPath: KeyPath<Return, AppendedReturn>
    ) -> (Root) -> AppendedReturn {
        appending(keyPath: keyPath)
    }

    public subscript<AppendedReturn>(
        dynamicMember keyPath: KeyPath<Return, AppendedReturn>
    ) -> FunctionPathWithInput<Root, AppendedReturn> {
        appending(keyPath: keyPath)
    }

    // MARK: - appending

    public func appending<Input, AppendedReturn>(
        path: FunctionPath<Return, Input, AppendedReturn>
    ) -> FunctionPath<Root, Input, AppendedReturn> {
        .init(
            call: { root in
                { input in
                    path.call(call(root))(input)
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

    @_disfavoredOverload
    public func appending<AppendedReturn>(
        keyPath: KeyPath<Return, AppendedReturn>
    ) -> (Root) -> AppendedReturn {
        { root in
            self.call(root)[keyPath: keyPath]
        }
    }

    public func appending<AppendedReturn>(
        keyPath: KeyPath<Return, AppendedReturn>
    ) -> FunctionPathWithInput<Root, AppendedReturn> {
        .init { root in
            self.call(root)[keyPath: keyPath]
        }
    }

    // MARK: - callAsFunction

    public func callAsFunction(
        _ root: Root
    ) -> Return {
        call(root)
    }
}

extension FunctionPathWithInput where Return == Root {
    public static var `self`: Self {
        .init()
    }

    public init() {
        self.init(call: { root in return root})
    }
}

// MARK: - CustomDebugStringConvertible
extension FunctionPathWithInput: CustomDebugStringConvertible {
    public var debugDescription: String {
        "FunctionPathWithInput<\(Root.self), \(Return.self)>"
    }
}
