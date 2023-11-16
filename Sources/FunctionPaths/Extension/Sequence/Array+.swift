//
//  Array+.swift
//
//
//  Created by p-x9 on 2023/11/15.
//  
//

import Foundation

extension Array {
    @inlinable
    public mutating func removeAll(where shouldBeRemoved: FunctionPathWithInput<Self.Element, Bool>) {
        removeAll(where: shouldBeRemoved.call)
    }

    @inlinable
    public func last(where predicate: FunctionPathWithInput<Self.Element, Bool>) -> Self.Element? {
        last(where: predicate.call)
    }

    @inlinable
    public func lastIndex(where predicate: FunctionPathWithInput<Self.Element, Bool>) -> Self.Index? {
        lastIndex(where: predicate.call)
    }

    @inlinable
    public func drop(while predicate: FunctionPathWithInput<Self.Element, Bool>) -> Self.SubSequence {
        drop(while: predicate.call)
    }
}

// MARK: - ThrowingFunctionPath
extension Array {
    @inlinable
    public mutating func removeAll(where shouldBeRemoved: ThrowingFunctionPathWithInput<Self.Element, Bool>) throws {
        try removeAll(where: shouldBeRemoved.call)
    }

    @inlinable
    public func last(where predicate: ThrowingFunctionPathWithInput<Self.Element, Bool>) throws -> Self.Element? {
        try last(where: predicate.call)
    }

    @inlinable
    public func lastIndex(where predicate: ThrowingFunctionPathWithInput<Self.Element, Bool>) throws -> Self.Index? {
        try lastIndex(where: predicate.call)
    }

    @inlinable
    public func drop(while predicate: ThrowingFunctionPathWithInput<Self.Element, Bool>) throws -> Self.SubSequence {
        try drop(while: predicate.call)
    }
}
