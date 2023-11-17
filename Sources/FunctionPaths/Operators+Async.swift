//
//  Operators+Async.swift
//
//
//  Created by p-x9 on 2023/11/17.
//  
//

import Foundation

// MARK: - Closure

public prefix func | <Root, Input, Return>(
    call: @escaping ((Root) -> (Input) async -> Return)
) -> AsyncFunctionPath<Root, Input, Return> {
    return .init(call: call)
}

public prefix func | <Root, each T, Return>(
    call: @escaping ((Root) -> (repeat each T) async -> Return)
) -> AsyncFunctionPath<Root, (repeat each T), Return> {
    return .init { root in
        { input in
            await call(root)(repeat each input)
        }
    }
}

public prefix func | <Root, Return>(
    call: @escaping ((Root) -> () async -> Return)
) -> AsyncFunctionPathWithInput<Root, Return> {
    return .init { root in
        await call(root)()
    }
}

@_disfavoredOverload
public prefix func | <Root, Return>(
    call: @escaping ((Root) -> () async -> Return)
) -> AsyncFunctionPath<Root, Void, Return> {
    return .init { root in
        { _ in
            await call(root)()
        }
    }
}

// MARK: - Root

@_disfavoredOverload
public prefix func | <Root>(
    root: Root
) -> AsyncFunctionPath<Root, Void, Root> {
    return .self
}

@_disfavoredOverload
public prefix func | <Root>(
    root: Root
) -> AsyncFunctionPathWithInput<Root, Root> {
    return .self
}

// MARK: - Root Type

@_disfavoredOverload
public prefix func | <Root>(
    type: Root.Type
) -> AsyncFunctionPath<Root, Void, Root> {
    return .self
}

@_disfavoredOverload
public prefix func | <Root>(
    type: Root.Type
) -> AsyncFunctionPathWithInput<Root, Root> {
    return .self
}

// MARK: - funcPath

@_disfavoredOverload
public prefix func | <Root, Input, Return>(
    path: AsyncFunctionPath<Root, Input, Return>
) -> AsyncFunctionPath<Root, Input, Return> {
    path
}

@_disfavoredOverload
public prefix func | <Root, Return>(
    path: AsyncFunctionPathWithInput<Root, Return>
) -> AsyncFunctionPathWithInput<Root, Return> {
    path
}

// MARK: - KeyPath → FunctionPath

@_disfavoredOverload
public prefix func | <Root, Return>(
    keyPath: KeyPath<Root, Return>
) -> AsyncFunctionPath<Root, Void, Return> {
    .init(call: { root in
        { _ in
            root[keyPath: keyPath]
        }
    })
}

@_disfavoredOverload
public prefix func | <Root, Return>(
    keyPath: KeyPath<Root, Return>
) -> AsyncFunctionPathWithInput<Root, Return> {
    .init(call: { root in
        root[keyPath: keyPath]
    })
}
