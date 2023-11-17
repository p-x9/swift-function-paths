//
//  ThrowingFunctionPathWithInput+conversion.swift
//
//
//  Created by p-x9 on 2023/11/17.
//  
//

import Foundation

extension ThrowingFunctionPathWithInput {
    public init(_ funcPathWithInput: FunctionPathWithInput<Root, Return>) {
        self.init(call: funcPathWithInput.call)
    }
}
