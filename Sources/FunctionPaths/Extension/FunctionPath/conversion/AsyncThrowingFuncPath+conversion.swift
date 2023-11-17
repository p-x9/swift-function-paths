//
//  AsyncThrowingFuncPath+conversion.swift
//
//
//  Created by p-x9 on 2023/11/17.
//  
//

import Foundation

extension AsyncThrowingFuncPath {
    public init(_ funcPath: FunctionPath<Root, Input, Return>) {
        self.init(call: funcPath.call)
    }

    public init(_ funcPath: ThrowingFunctionPath<Root, Input, Return>) {
        self.init(call: funcPath.call)
    }

    public init(_ funcPath: AsyncFunctionPath<Root, Input, Return>) {
        self.init(call: funcPath.call)
    }
}
