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
