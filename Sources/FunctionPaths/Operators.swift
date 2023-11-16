//
//  Operators.swift
//  
//
//  Created by p-x9 on 2023/11/14.
//  
//

import Foundation

// MARK: - Operator

prefix operator |


// MARK: - Closure

public prefix func | <Root, Input, Return>(
    call: @escaping ((Root) -> (Input) -> Return)
) -> FunctionPath<Root, Input, Return> {
    return FunctionPath(call: call)
}

public prefix func | <Root, each T, Return>(
    call: @escaping ((Root) -> (repeat each T) -> Return)
) -> FunctionPath<Root, (repeat each T), Return> {
    return .init { root in
        { input in
            call(root)(repeat each input)
        }
    }
}

public prefix func | <Root, Return>(
    call: @escaping ((Root) -> () -> Return)
) -> FunctionPathWithInput<Root, Return> {
    return .init { root in
        call(root)()
    }
}

@_disfavoredOverload
public prefix func | <Root, Return>(
    call: @escaping ((Root) -> () -> Return)
) -> FunctionPath<Root, Void, Return> {
    return .init { root in
        { _ in
            call(root)()
        }
    }
}

// MARK: - Root

@_disfavoredOverload
public prefix func | <Root>(
    root: Root
) -> FunctionPath<Root, Void, Root> {
    return .self
}

public prefix func | <Root>(
    root: Root
) -> FunctionPathWithInput<Root, Root> {
    return .self
}

// MARK: - Root Type

@_disfavoredOverload
public prefix func | <Root>(
    type: Root.Type
) -> FunctionPath<Root, Void, Root> {
    return .self
}

public prefix func | <Root>(
    type: Root.Type
) -> FunctionPathWithInput<Root, Root> {
    return .self
}

// MARK: - funcPath

public prefix func | <Root, Input, Return>(
    path: FunctionPath<Root, Input, Return>
) -> FunctionPath<Root, Input, Return> {
    path
}

public prefix func | <Root, Return>(
    path: FunctionPathWithInput<Root, Return>
) -> FunctionPathWithInput<Root, Return> {
    path
}

// MARK: - KeyPath → FunctionPath

@_disfavoredOverload
public prefix func | <Root, Return>(
    keyPath: KeyPath<Root, Return>
) -> FunctionPath<Root, Void, Return> {
    .init(call: { root in
        { _ in
            root[keyPath: keyPath]
        }
    })
}

public prefix func | <Root, Return>(
    keyPath: KeyPath<Root, Return>
) -> FunctionPathWithInput<Root, Return> {
    .init(call: { root in
        root[keyPath: keyPath]
    })
}
