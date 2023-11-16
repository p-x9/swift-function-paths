//
//  Sequence+.swift
//
//
//  Created by p-x9 on 2023/11/15.
//  
//

import Foundation

extension Sequence {

    // MARK: - Finding Elements

    @inlinable
    public func contains(where predicate: FunctionPathWithInput<Self.Element, Bool>) -> Bool {
        contains(where: predicate.call)
    }

    @inlinable
    public func allSatisfy(_ predicate: FunctionPathWithInput<Self.Element, Bool>) -> Bool {
        allSatisfy(predicate.call)
    }

    @inlinable
    public func first(where predicate: FunctionPathWithInput<Self.Element, Bool>) -> Self.Element? {
        first(where: predicate.call)
    }

    @inlinable
    public func min(
        by areInIncreasingOrder: FunctionPathWithInput<(Self.Element, Self.Element), Bool>
    ) -> Self.Element? {
        self.min(by: { lhs, rhs in
            areInIncreasingOrder.call((lhs, rhs))
        })
    }

    @inlinable
    public func max(
        by areInIncreasingOrder: FunctionPathWithInput<(Self.Element, Self.Element), Bool>
    ) -> Self.Element? {
        self.max(by: { lhs, rhs in
            areInIncreasingOrder.call((lhs, rhs))
        })
    }


    // MARK: - Selecting Elements

    @inlinable
    public func prefix(while predicate: FunctionPathWithInput<Self.Element, Bool>) -> [Self.Element] {
        prefix(while: predicate.call)
    }

    // MARK: - Excluding Elements

    @inlinable
    public func drop(while predicate: FunctionPathWithInput<Self.Element, Bool>) -> DropWhileSequence<Self> {
        drop(while: predicate.call)
    }

    @inlinable
    public func filter(_ isIncluded: FunctionPathWithInput<Self.Element, Bool>) -> [Self.Element] {
        filter(isIncluded.call)
    }

    // MARK: - Transforming a Sequence

    @inlinable
    public func map<T>(_ transform: FunctionPathWithInput<Self.Element, T>) -> [T] {
        map(transform.call)
    }

    @inlinable
    public func compactMap<ElementOfResult>(
        _ transform: FunctionPathWithInput<Self.Element, ElementOfResult?>
    ) -> [ElementOfResult] {
        compactMap(transform.call)
    }

    @inlinable
    public func reduce<Result>(
        _ initialResult: Result,
        _ nextPartialResult: FunctionPathWithInput<(Result, Self.Element), Result>
    ) -> Result {
        reduce(initialResult, { result, element in
            nextPartialResult.call((result, element))
        })
    }

    // MARK: - Iterating Over a Sequence’s Elements

    @inlinable
    public func forEach(_ body: FunctionPathWithInput<Self.Element, Void>) {
        forEach(body.call)
    }

    // MARK: - Sorting Elements

    @inlinable
    public func sorted(
        by areInIncreasingOrder: FunctionPathWithInput<(Self.Element, Self.Element), Bool>
    ) -> [Self.Element] {
        sorted(by: { lhs, rhs in
            areInIncreasingOrder.call((lhs, rhs))
        })
    }
}

// MARK: - ThrowingFunctionPath
extension Sequence {

    // MARK: - Finding Elements

    @inlinable
    public func contains(where predicate: ThrowingFunctionPathWithInput<Self.Element, Bool>) throws -> Bool {
        try contains(where: predicate.call)
    }

    @inlinable
    public func allSatisfy(_ predicate: ThrowingFunctionPathWithInput<Self.Element, Bool>) throws -> Bool {
        try allSatisfy(predicate.call)
    }

    @inlinable
    public func first(where predicate: ThrowingFunctionPathWithInput<Self.Element, Bool>) throws -> Self.Element? {
        try first(where: predicate.call)
    }

    @inlinable
    public func min(
        by areInIncreasingOrder: ThrowingFunctionPathWithInput<(Self.Element, Self.Element), Bool>
    ) throws -> Self.Element? {
        try self.min(by: { lhs, rhs in
            try areInIncreasingOrder.call((lhs, rhs))
        })
    }

    @inlinable
    public func max(
        by areInIncreasingOrder: ThrowingFunctionPathWithInput<(Self.Element, Self.Element), Bool>
    ) throws -> Self.Element? {
        try self.max(by: { lhs, rhs in
            try areInIncreasingOrder.call((lhs, rhs))
        })
    }


    // MARK: - Selecting Elements

    @inlinable
    public func prefix(while predicate: ThrowingFunctionPathWithInput<Self.Element, Bool>) throws -> [Self.Element] {
        try prefix(while: predicate.call)
    }

    // MARK: - Excluding Elements

    @inlinable
    public func drop(while predicate: ThrowingFunctionPathWithInput<Self.Element, Bool>) throws -> DropWhileSequence<Self> {
        try drop(while: predicate.call)
    }

    @inlinable
    public func filter(_ isIncluded: ThrowingFunctionPathWithInput<Self.Element, Bool>) throws -> [Self.Element] {
        try filter(isIncluded.call)
    }

    // MARK: - Transforming a Sequence

    @inlinable
    public func map<T>(_ transform: ThrowingFunctionPathWithInput<Self.Element, T>) throws -> [T] {
        try map(transform.call)
    }

    @inlinable
    public func compactMap<ElementOfResult>(
        _ transform: ThrowingFunctionPathWithInput<Self.Element, ElementOfResult?>
    ) throws -> [ElementOfResult] {
        try compactMap(transform.call)
    }

    @inlinable
    public func reduce<Result>(
        _ initialResult: Result,
        _ nextPartialResult: ThrowingFunctionPathWithInput<(Result, Self.Element), Result>
    ) throws -> Result {
        try reduce(initialResult, { result, element in
            try nextPartialResult.call((result, element))
        })
    }

    // MARK: - Iterating Over a Sequence’s Elements

    @inlinable
    public func forEach(_ body: ThrowingFunctionPathWithInput<Self.Element, Void>) throws {
        try forEach(body.call)
    }

    // MARK: - Sorting Elements

    @inlinable
    public func sorted(
        by areInIncreasingOrder: ThrowingFunctionPathWithInput<(Self.Element, Self.Element), Bool>
    ) throws -> [Self.Element] {
        try sorted(by: { lhs, rhs in
            try areInIncreasingOrder.call((lhs, rhs))
        })
    }
}
