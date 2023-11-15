//
//  Collection+.swift
//
//
//  Created by p-x9 on 2023/11/15.
//  
//

import Foundation

extension Collection {
    @inlinable
    public func drop(while predicate: FunctionPathWithInput<Self.Element, Bool>) -> Self.SubSequence {
        drop(while: predicate.call)
    }

    @inlinable
    public func firstIndex(where predicate: FunctionPathWithInput<Self.Element, Bool>) -> Self.Index? {
        firstIndex(where: predicate.call)
    }

    @inlinable
    public func prefix(while predicate: FunctionPathWithInput<Self.Element, Bool>) -> Self.SubSequence {
        prefix(while: predicate.call)
    }

    @available(macOS 13.0, iOS 16.0, watchOS 9.0, tvOS 16.0, *)
    @inlinable
    public func trimmingPrefix(while predicate: FunctionPathWithInput<Self.Element, Bool>) -> Self.SubSequence {
        trimmingPrefix(while: predicate.call)
    }
}
