//
//  AsyncThrowingFuncPath+MultiArgsSupport.swift
//
//
//  Created by p-x9 on 2023/11/17.
//  
//

import Foundation

extension AsyncThrowingFunctionPath {

    // MARK: 2 args
    @_disfavoredOverload
    public func callAsFunction<In1, In2>(
        _ arg1: @escaping @autoclosure () -> In1,
        _ arg2: @escaping @autoclosure () -> In2
    ) -> (Root) async throws -> Return where Input == (In1, In2) {
        { root in
            try await call(root)((arg1(), arg2()))
        }
    }

    public func callAsFunction<In1, In2>(
        _ arg1: @escaping @autoclosure () -> In1,
        _ arg2: @escaping @autoclosure () -> In2
    ) -> AsyncThrowingFunctionPathWithInput<Root, Return> where Input == (In1, In2) {
        .init(
            call: call,
            input: (arg1(), arg2())
        )
    }

    // MARK: 3 args
    @_disfavoredOverload
    public func callAsFunction<In1, In2, In3>(
        _ arg1: @escaping @autoclosure () -> In1,
        _ arg2: @escaping @autoclosure () -> In2,
        _ arg3: @escaping @autoclosure () -> In3
    ) -> (Root) async throws -> Return where Input == (In1, In2, In3) {
        { root in
            try await call(root)((arg1(), arg2(), arg3()))
        }
    }

    public func callAsFunction<In1, In2, In3>(
        _ arg1: @escaping @autoclosure () -> In1,
        _ arg2: @escaping @autoclosure () -> In2,
        _ arg3: @escaping @autoclosure () -> In3
    ) -> AsyncThrowingFunctionPathWithInput<Root, Return> where Input == (In1, In2, In3) {
        .init(
            call: call,
            input: (arg1(), arg2(), arg3())
        )
    }

    // MARK: 4 args
    @_disfavoredOverload
    public func callAsFunction<In1, In2, In3, In4>(
        _ arg1: @escaping @autoclosure () -> In1,
        _ arg2: @escaping @autoclosure () -> In2,
        _ arg3: @escaping @autoclosure () -> In3,
        _ arg4: @escaping @autoclosure () -> In4
    ) -> (Root) async throws -> Return where Input == (In1, In2, In3, In4) {
        { root in
            try await call(root)((arg1(), arg2(), arg3(), arg4()))
        }
    }

    public func callAsFunction<In1, In2, In3, In4>(
        _ arg1: @escaping @autoclosure () -> In1,
        _ arg2: @escaping @autoclosure () -> In2,
        _ arg3: @escaping @autoclosure () -> In3,
        _ arg4: @escaping @autoclosure () -> In4
    ) -> AsyncThrowingFunctionPathWithInput<Root, Return> where Input == (In1, In2, In3, In4) {
        .init(
            call: call,
            input: (arg1(), arg2(), arg3(), arg4())
        )
    }

    // MARK: 5 args
    @_disfavoredOverload
    public func callAsFunction<In1, In2, In3, In4, In5>(
        _ arg1: @escaping @autoclosure () -> In1,
        _ arg2: @escaping @autoclosure () -> In2,
        _ arg3: @escaping @autoclosure () -> In3,
        _ arg4: @escaping @autoclosure () -> In4,
        _ arg5: @escaping @autoclosure () -> In5
    ) -> (Root) async throws -> Return where Input == (In1, In2, In3, In4, In5) {
        { root in
            try await call(root)((arg1(), arg2(), arg3(), arg4(), arg5()))
        }
    }

    public func callAsFunction<In1, In2, In3, In4, In5>(
        _ arg1: @escaping @autoclosure () -> In1,
        _ arg2: @escaping @autoclosure () -> In2,
        _ arg3: @escaping @autoclosure () -> In3,
        _ arg4: @escaping @autoclosure () -> In4,
        _ arg5: @escaping @autoclosure () -> In5
    ) -> AsyncThrowingFunctionPathWithInput<Root, Return> where Input == (In1, In2, In3, In4, In5) {
        .init(
            call: call,
            input: (arg1(), arg2(), arg3(), arg4(), arg5())
        )
    }
}