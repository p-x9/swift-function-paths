//
//  FuncPathAccessable.swift
//
//
//  Created by p-x9 on 2023/11/15.
//  
//

import Foundation

@_marker
public protocol FuncPathAccessable {}

extension FuncPathAccessable {
    public subscript<Input, Return>(
        funcPath path: FunctionPath<Self, Input, Return>
    ) -> (Input) -> Return {
        path.call(self)
    }

    public subscript<Return>(
        funcPath path: FunctionPathWithInput<Self, Return>
    ) -> Return {
        path.call(self)
    }
}

extension FuncPathAccessable {
    public subscript<Input, Return>(
        funcPath path: ThrowingFunctionPath<Self, Input, Return>
    ) -> (Input) throws -> Return {
        path.call(self)
    }
}

extension FuncPathAccessable {
    public subscript<Input, Return>(
        funcPath path: AsyncFunctionPath<Self, Input, Return>
    ) -> (Input) async -> Return {
        path.call(self)
    }
}

extension FuncPathAccessable {
    public subscript<Input, Return>(
        funcPath path: AsyncThrowingFunctionPath<Self, Input, Return>
    ) -> (Input) async throws -> Return {
        path.call(self)
    }
}
