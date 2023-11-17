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
