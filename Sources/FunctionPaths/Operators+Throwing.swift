//
//  Operators+Throwing.swift
//
//
//  Created by p-x9 on 2023/11/16.
//  
//

import Foundation

// MARK: - Closure

public prefix func | <Root, Input, Return>(
    call: @escaping ((Root) -> (Input) throws -> Return)
) -> ThrowingFunctionPath<Root, Input, Return> {
    return .init(call: call)
}

public prefix func | <Root, each T, Return>(
    call: @escaping ((Root) -> (repeat each T) throws -> Return)
) -> ThrowingFunctionPath<Root, (repeat each T), Return> {
    return .init { root in
        { input in
            try call(root)(repeat each input)
        }
    }
}

public prefix func | <Root, Return>(
    call: @escaping ((Root) -> () throws -> Return)
) -> ThrowingFunctionPathWithInput<Root, Return> {
    return .init { root in
        try call(root)()
    }
}

@_disfavoredOverload
public prefix func | <Root, Return>(
    call: @escaping ((Root) -> () throws -> Return)
) -> ThrowingFunctionPath<Root, Void, Return> {
    return .init { root in
        { _ in
            try call(root)()
        }
    }
}

// MARK: - Root

@_disfavoredOverload
public prefix func | <Root>(
    root: Root
) -> ThrowingFunctionPath<Root, Void, Root> {
    return .self
}

@_disfavoredOverload
public prefix func | <Root>(
    root: Root
) -> ThrowingFunctionPathWithInput<Root, Root> {
    return .self
}

// MARK: - Root Type

@_disfavoredOverload
public prefix func | <Root>(
    type: Root.Type
) -> ThrowingFunctionPath<Root, Void, Root> {
    return .self
}

@_disfavoredOverload
public prefix func | <Root>(
    type: Root.Type
) -> ThrowingFunctionPathWithInput<Root, Root> {
    return .self
}

// MARK: - funcPath

@_disfavoredOverload
public prefix func | <Root, Input, Return>(
    path: ThrowingFunctionPath<Root, Input, Return>
) -> ThrowingFunctionPath<Root, Input, Return> {
    path
}

@_disfavoredOverload
public prefix func | <Root, Return>(
    path: ThrowingFunctionPathWithInput<Root, Return>
) -> ThrowingFunctionPathWithInput<Root, Return> {
    path
}

// MARK: - KeyPath → FunctionPath

@_disfavoredOverload
public prefix func | <Root, Return>(
    keyPath: KeyPath<Root, Return>
) -> ThrowingFunctionPath<Root, Void, Return> {
    .init(call: { root in
        { _ in
            root[keyPath: keyPath]
        }
    })
}

@_disfavoredOverload
public prefix func | <Root, Return>(
    keyPath: KeyPath<Root, Return>
) -> ThrowingFunctionPathWithInput<Root, Return> {
    .init(call: { root in
        root[keyPath: keyPath]
    })
}
