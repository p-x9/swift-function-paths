//
//  KeyPath+.swift
//
//
//  Created by p-x9 on 2023/11/15.
//  
//

import Foundation

extension KeyPath {
    public func appending<Input, AppendedReturn>(
        path: FunctionPath<Value, Input, AppendedReturn>
    ) -> FunctionPath<Root, Input, AppendedReturn> {
        .init(
            call: { root in
                { input in
                    path.call(root[keyPath: self])(input)
                }
            }
        )
    }

    public func appending<AppendedReturn>(
        path: FunctionPathWithInput<Value, AppendedReturn>
    ) -> FunctionPathWithInput<Root, AppendedReturn> {
        .init(
            call: { root in
                path.call(root[keyPath: self])
            }
        )
    }
}

extension KeyPath {
    public func appending<Input, AppendedReturn>(
        path: ThrowingFunctionPath<Value, Input, AppendedReturn>
    ) -> ThrowingFunctionPath<Root, Input, AppendedReturn> {
        .init(
            call: { root in
                { input in
                    try path.call(root[keyPath: self])(input)
                }
            }
        )
    }

    public func appending<AppendedReturn>(
        path: ThrowingFunctionPathWithInput<Value, AppendedReturn>
    ) -> ThrowingFunctionPathWithInput<Root, AppendedReturn> {
        .init(
            call: { root in
                try path.call(root[keyPath: self])
            }
        )
    }
}

extension KeyPath {
    public func appending<Input, AppendedReturn>(
        path: AsyncFunctionPath<Value, Input, AppendedReturn>
    ) -> AsyncFunctionPath<Root, Input, AppendedReturn> {
        .init(
            call: { root in
                { input in
                    await path.call(root[keyPath: self])(input)
                }
            }
        )
    }

    public func appending<AppendedReturn>(
        path: AsyncFunctionPathWithInput<Value, AppendedReturn>
    ) -> AsyncFunctionPathWithInput<Root, AppendedReturn> {
        .init(
            call: { root in
                await path.call(root[keyPath: self])
            }
        )
    }
}

extension KeyPath {
    public func appending<Input, AppendedReturn>(
        path: AsyncThrowingFunctionPath<Value, Input, AppendedReturn>
    ) -> AsyncThrowingFunctionPath<Root, Input, AppendedReturn> {
        .init(
            call: { root in
                { input in
                    try await path.call(root[keyPath: self])(input)
                }
            }
        )
    }

    public func appending<AppendedReturn>(
        path: AsyncThrowingFunctionPathWithInput<Value, AppendedReturn>
    ) -> AsyncThrowingFunctionPathWithInput<Root, AppendedReturn> {
        .init(
            call: { root in
                try await path.call(root[keyPath: self])
            }
        )
    }
}
