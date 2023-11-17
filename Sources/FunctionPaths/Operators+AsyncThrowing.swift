//
//  Operators+AsyncThrowing.swift
//
//
//  Created by p-x9 on 2023/11/17.
//  
//

import Foundation

// MARK: - Closure

public prefix func | <Root, Input, Return>(
    call: @escaping ((Root) -> (Input) async throws -> Return)
) -> AsyncThrowingFunctionPath<Root, Input, Return> {
    return .init(call: call)
}

public prefix func | <Root, each T, Return>(
    call: @escaping ((Root) -> (repeat each T) async throws -> Return)
) -> AsyncThrowingFunctionPath<Root, (repeat each T), Return> {
    return .init { root in
        { input in
            try await call(root)(repeat each input)
        }
    }
}

public prefix func | <Root, Return>(
    call: @escaping ((Root) -> () async throws -> Return)
) -> AsyncThrowingFunctionPathWithInput<Root, Return> {
    return .init { root in
        try await call(root)()
    }
}

@_disfavoredOverload
public prefix func | <Root, Return>(
    call: @escaping ((Root) -> () async throws -> Return)
) -> AsyncThrowingFunctionPath<Root, Void, Return> {
    return .init { root in
        { _ in
            try await call(root)()
        }
    }
}

// MARK: - Root

@_disfavoredOverload
public prefix func | <Root>(
    root: Root
) -> AsyncThrowingFunctionPath<Root, Void, Root> {
    return .self
}

@_disfavoredOverload
public prefix func | <Root>(
    root: Root
) -> AsyncThrowingFunctionPathWithInput<Root, Root> {
    return .self
}

// MARK: - Root Type

@_disfavoredOverload
public prefix func | <Root>(
    type: Root.Type
) -> AsyncThrowingFunctionPath<Root, Void, Root> {
    return .self
}

@_disfavoredOverload
public prefix func | <Root>(
    type: Root.Type
) -> AsyncThrowingFunctionPathWithInput<Root, Root> {
    return .self
}

// MARK: - funcPath

@_disfavoredOverload
public prefix func | <Root, Input, Return>(
    path: AsyncThrowingFunctionPath<Root, Input, Return>
) -> AsyncThrowingFunctionPath<Root, Input, Return> {
    path
}

@_disfavoredOverload
public prefix func | <Root, Return>(
    path: AsyncThrowingFunctionPathWithInput<Root, Return>
) -> AsyncThrowingFunctionPathWithInput<Root, Return> {
    path
}

// MARK: - KeyPath → FunctionPath

@_disfavoredOverload
public prefix func | <Root, Return>(
    keyPath: KeyPath<Root, Return>
) -> AsyncThrowingFunctionPath<Root, Void, Return> {
    .init(call: { root in
        { _ in
            root[keyPath: keyPath]
        }
    })
}

@_disfavoredOverload
public prefix func | <Root, Return>(
    keyPath: KeyPath<Root, Return>
) -> AsyncThrowingFunctionPathWithInput<Root, Return> {
    .init(call: { root in
        root[keyPath: keyPath]
    })
}
