//
//  AsyncThrowingFuncPathWithInput+conversion.swift
//
//
//  Created by p-x9 on 2023/11/17.
//  
//

import Foundation

extension AsyncThrowingFunctionPathWithInput {
    public init(_ funcPathWithInput: FunctionPathWithInput<Root, Return>) {
        self.init(call: funcPathWithInput.call)
    }

    public init(_ funcPathWithInput: ThrowingFunctionPathWithInput<Root, Return>) {
        self.init(call: funcPathWithInput.call)
    }

    public init(_ funcPathWithInput: AsyncThrowingFunctionPathWithInput<Root, Return>) {
        self.init(call: funcPathWithInput.call)
    }
}

