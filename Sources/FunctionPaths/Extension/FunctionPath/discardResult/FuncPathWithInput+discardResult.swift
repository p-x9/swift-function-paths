//
//  FuncPathWithInput+discardResult.swift
//
//
//  Created by p-x9 on 2023/11/24.
//  
//

import Foundation

extension FunctionPathWithInput {
    public func discardResult() -> FunctionPathWithInput<Root, Void> {
        .init { root in
            _ = call(root)
        }
    }
}

extension ThrowingFunctionPathWithInput {
    public func discardResult() -> ThrowingFunctionPathWithInput<Root, Void> {
        .init { root in
            _ = try call(root)
        }
    }
}

extension AsyncFunctionPathWithInput {
    public func discardResult() -> AsyncFunctionPathWithInput<Root, Void> {
        .init { root in
            _ = await call(root)
        }
    }
}

extension AsyncThrowingFunctionPathWithInput {
    public func discardResult() -> AsyncThrowingFunctionPathWithInput<Root, Void> {
        .init { root in
            _ = try await call(root)
        }
    }
}
