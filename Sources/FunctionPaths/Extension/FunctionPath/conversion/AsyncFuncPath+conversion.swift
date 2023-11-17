//
//  AsyncFuncPath+conversion.swift
//
//
//  Created by p-x9 on 2023/11/17.
//  
//

import Foundation

extension AsyncFunctionPath {
    public init(_ funcPath: FunctionPath<Root, Input, Return>) {
        self.init(call: funcPath.call)
    }
}
