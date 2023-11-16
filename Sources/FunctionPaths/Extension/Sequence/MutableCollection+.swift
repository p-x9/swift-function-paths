//
//  MutableCollection+.swift
//
//
//  Created by p-x9 on 2023/11/15.
//  
//

import Foundation

extension MutableCollection {
    @inlinable
    public mutating func partition(by belongsInSecondPartition: FunctionPathWithInput<Self.Element, Bool>) -> Self.Index {
        partition(by: belongsInSecondPartition.call)
    }
}

extension MutableCollection where Self: RandomAccessCollection {
    @inlinable
    public mutating func sort(by areInIncreasingOrder: FunctionPathWithInput<(Self.Element, Self.Element), Bool>) {
        sort(by: { lhs, rhs in
            areInIncreasingOrder.call((lhs, rhs))
        })
    }
}

// MARK: - ThrowingFunctionPath
extension MutableCollection {
    @inlinable
    public mutating func partition(by belongsInSecondPartition: ThrowingFunctionPathWithInput<Self.Element, Bool>) throws -> Self.Index {
        try partition(by: belongsInSecondPartition.call)
    }
}

extension MutableCollection where Self: RandomAccessCollection {
    @inlinable
    public mutating func sort(by areInIncreasingOrder: ThrowingFunctionPathWithInput<(Self.Element, Self.Element), Bool>) throws {
        try sort(by: { lhs, rhs in
            try areInIncreasingOrder.call((lhs, rhs))
        })
    }
}
