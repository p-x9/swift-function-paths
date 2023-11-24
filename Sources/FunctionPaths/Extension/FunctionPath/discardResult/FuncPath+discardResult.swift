//
//  FuncPath+discardResult.swift
//
//
//  Created by p-x9 on 2023/11/24.
//  
//

import Foundation

extension FunctionPath {
    public func discardResult() -> FunctionPath<Root, Input, Void> {
        .init { root in
            { input in
                _ = call(root)(input)
            }
        }
    }
}

extension ThrowingFunctionPath {
    public func discardResult() -> ThrowingFunctionPath<Root, Input, Void> {
        .init { root in
            { input in
                _ = try call(root)(input)
            }
        }
    }
}

extension AsyncFunctionPath {
    public func discardResult() -> AsyncFunctionPath<Root, Input, Void> {
        .init { root in
            { input in
                _ = await call(root)(input)
            }
        }
    }
}

extension AsyncThrowingFunctionPath {
    public func discardResult() -> AsyncThrowingFunctionPath<Root, Input, Void> {
        .init { root in
            { input in
                _ = try await call(root)(input)
            }
        }
    }
}
