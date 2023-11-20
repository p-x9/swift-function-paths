//
//  Data.swift
//
//
//  Created by p-x9 on 2023/11/20.
//  
//

import Foundation
import FunctionPaths

struct Item {
    let title: String
    let value: Int

    var string: String {
        "\(title), \(value)"
    }

    init(title: String, value: Int) {
        self.title = title
        self.value = value
    }

    // No arguments, no return value, no throws, not async
    func noArgsNoReturn() {
        print("noArgsNoReturn called: \(string)")
    }

    // With arguments, no return value, no throws, not async
    func withArgsNoReturn(arg1: Int, arg2: String) {
        print("withArgsNoReturn called with arg1: \(arg1), arg2: \(arg2), \(string)")
    }

    // No arguments, with return value, no throws, not async
    func noArgsWithReturn() -> Int {
        return value
    }

    // With arguments, with return value, no throws, not async
    func withArgsWithReturn(arg1: Double, arg2: String) -> String {
        return string + " \(arg1) \(arg2)"
    }

    // No arguments, no return value, throws error, not async
    func noArgsWithError() throws {
        throw ItemError.dummy
    }

    // With arguments, no return value, throws error, not async
    func withArgsWithError(arg1: Bool) throws {
        if arg1 {
            throw ItemError.dummy
        }
    }

    // No arguments, with return value, throws error, not async
    func noArgsWithReturnWithError() throws -> String {
        return string
    }

    // With arguments, with return value, throws error, not async
    func withArgsWithReturnWithError(arg1: Int, arg2: String) throws -> String {
        if arg1 < 0 {
            throw ItemError.dummy
        }
        return "Result: \(arg1) - \(arg2)"
    }

    // No arguments, no return value, no throws, async
    func noArgsNoReturnAsync() async {
        try? await Task.sleep(nanoseconds: 1 * 1_000_000) 
        print("noArgsNoReturnAsync called \(string)")
    }

    // With arguments, no return value, no throws, async
    func withArgsNoReturnAsync(arg1: Double, arg2: String) async {
        try? await Task.sleep(nanoseconds: 1 * 1_000_000) 
        print("withArgsNoReturnAsync called with arg1: \(arg1), arg2: \(arg2) \(string)")
    }

    // No arguments, with return value, no throws, async
    func noArgsWithReturnAsync() async -> Int {
        try? await Task.sleep(nanoseconds: 1 * 1_000_000) 
        return value
    }

    // With arguments, with return value, no throws, async
    func withArgsWithReturnAsync(arg1: Int, arg2: String) async -> String {
        try? await Task.sleep(nanoseconds: 1 * 1_000_000) 
        return "Async Result: \(arg1) - \(arg2) \(string)"
    }

    // No arguments, no return value, throws error, async
    func noArgsWithErrorAsync() async throws {
        try await Task.sleep(nanoseconds: 1 * 1_000_000) 
        throw ItemError.dummy
    }

    // With arguments, no return value, throws error, async
    func withArgsWithErrorAsync(arg1: Bool) async throws {
        try await Task.sleep(nanoseconds: 1 * 1_000_000) 
        if arg1 {
            throw ItemError.dummy
        }
    }

    // No arguments, with return value, throws error, async
    func noArgsWithReturnWithErrorAsync() async throws -> String {
        try await Task.sleep(nanoseconds: 1 * 1_000_000) 
        return string
    }

    // With arguments, with return value, throws error, async
    func withArgsWithReturnWithErrorAsync(arg1: Int, arg2: String) async throws -> String {
        try await Task.sleep(nanoseconds: 1 * 1_000_000) 
        if arg1 < 0 {
            throw ItemError.dummy
        }
        return "Async Result: \(arg1) - \(arg2) \(string)"
    }
}

enum ItemError: Error {
    case dummy
}

extension Item: FuncPathAccessable {}
