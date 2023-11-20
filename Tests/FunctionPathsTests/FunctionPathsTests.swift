import XCTest
@testable import FunctionPaths

final class FunctionPathsTests: XCTestCase {
    var item = Item(title: "hello", value: 5)
    var items: [Item] = []

    override func setUp() {
        items = [
            .init(title: "title1", value: 1),
            .init(title: "title2", value: 2),
            .init(title: "title3", value: 3),
            .init(title: "title4", value: 4),
            .init(title: "title5", value: 5),
            .init(title: "title6", value: 6),
            .init(title: "title7", value: 7),
            .init(title: "title8", value: 8),
            .init(title: "title9", value: 9),
            .init(title: "title10", value: 10),
        ]

        item = Item(title: "hello", value: 5)
    }


    func testFuncPath() throws {
        let noArgsNoReturn = |Item.noArgsNoReturn
        item[funcPath: noArgsNoReturn]
        noArgsNoReturn(item)

        let withArgsNoReturn = |Item.withArgsNoReturn
        item[funcPath: withArgsNoReturn((2, "str"))]
        item[funcPath: withArgsNoReturn(2, "str")]
        withArgsNoReturn(2, "str")(item)

        let noArgsWithReturn = |Item.noArgsWithReturn
        XCTAssertEqual(
            item[funcPath: noArgsWithReturn],
            item.noArgsWithReturn()
        )
        XCTAssertEqual(
            noArgsWithReturn(item),
            item.noArgsWithReturn()
        )

        let withArgsWithReturn = |Item.withArgsWithReturn
        let withArgsWithReturnWithInput = withArgsWithReturn(2.0, "arg2")
        XCTAssertEqual(
            item[funcPath: withArgsWithReturnWithInput],
            item.withArgsWithReturn(arg1: 2.0, arg2: "arg2")
        )
        XCTAssertEqual(
            withArgsWithReturnWithInput(item),
            item.withArgsWithReturn(arg1: 2.0, arg2: "arg2")
        )
    }

    func testThrowingFuncPath() throws {
        let noArgsWithError = |Item.noArgsWithError
        XCTAssertThrowsError(try noArgsWithError(item))

        let withArgsWithError = |Item.withArgsWithError
        XCTAssertThrowsError(try withArgsWithError(true)(item))

        let noArgsWithReturnWithError = |Item.noArgsWithReturnWithError
        XCTAssertEqual(
            try noArgsWithReturnWithError(item),
            try item.noArgsWithReturnWithError()
        )

        let withArgsWithReturnWithError = |Item.withArgsWithReturnWithError
        XCTAssertEqual(
            try withArgsWithReturnWithError(5, #function)(item),
            try item.withArgsWithReturnWithError(arg1: 5, arg2: #function)
        )
    }

    func testAsyncFuncPath() async throws {
        let noArgsNoReturnAsync = |Item.noArgsNoReturnAsync
        await noArgsNoReturnAsync(item)

        let withArgsNoReturnAsync = |Item.withArgsNoReturnAsync
        await withArgsNoReturnAsync(1.2, "ww")(item)

        let noArgsWithReturnAsync = |Item.noArgsWithReturnAsync
        let noArgsWithReturnAsyncResult = await noArgsWithReturnAsync(item)
        let noArgsWithReturnAsyncExpected =  await item.noArgsWithReturnAsync()
        XCTAssertEqual(
            noArgsWithReturnAsyncResult,
            noArgsWithReturnAsyncExpected
        )

        let withArgsWithReturnAsync = |Item.withArgsWithReturnAsync
        let withArgsWithReturnAsyncResult = await withArgsWithReturnAsync(6, #function)(item)
        let withArgsWithReturnAsyncExpected = await item.withArgsWithReturnAsync(arg1: 6, arg2: #function)
        XCTAssertEqual(
            withArgsWithReturnAsyncResult,
            withArgsWithReturnAsyncExpected
        )
    }

    func testAsyncThrowingFuncPath() async throws {
        let noArgsWithErrorAsync = |Item.noArgsWithErrorAsync
        try? await noArgsWithErrorAsync(item)

        let withArgsWithErrorAsync = |Item.withArgsWithErrorAsync
        try? await withArgsWithErrorAsync(false)(item)

        let noArgsWithReturnWithErrorAsync = |Item.noArgsWithReturnWithErrorAsync
        let noArgsWithReturnWithErrorAsyncResult = try? await item.noArgsWithReturnWithErrorAsync()
        let noArgsWithReturnWithErrorAsyncExpected = try? await noArgsWithReturnWithErrorAsync(item)
        XCTAssertEqual(
            noArgsWithReturnWithErrorAsyncResult,
            noArgsWithReturnWithErrorAsyncExpected
        )

        let withArgsWithReturnWithErrorAsync = |Item.withArgsWithReturnWithErrorAsync
        let withArgsWithReturnWithErrorAsyncResult = try? await item.withArgsWithReturnWithErrorAsync(arg1: 7, arg2: "321")
        let withArgsWithReturnWithErrorAsyncExpected = try? await withArgsWithReturnWithErrorAsync(7, "321")(item)
        XCTAssertEqual(
            withArgsWithReturnWithErrorAsyncResult,
            withArgsWithReturnWithErrorAsyncExpected
        )
    }

    func testFuncPathAppending() throws {
        let funcPath = |Item.withArgsWithReturn

        // keyPath
        XCTAssertEqual(
            item.withArgsWithReturn(arg1: 2.0, arg2: "w").count,
            item[funcPath: funcPath.count]((2.0, "w"))
        )

        // funcPath
        let hasPrefix = |String.hasPrefix
        let path = funcPath(2.0, "w").appending(path: hasPrefix)
        XCTAssertEqual(
            item.withArgsWithReturn(arg1: 2.0, arg2: "w")
                .hasPrefix("w"),
            path("w")(item)
        )
    }

    func testThrowingFuncPathAppending() throws {
        let funcPath = |Item.withArgsWithReturnWithError

        // keyPath
        XCTAssertEqual(
            try item.withArgsWithReturnWithError(arg1: 2, arg2: "w").count,
            try item[funcPath: funcPath.count]((2, "w"))
        )

        // funcPath
        let hasPrefix = |String.hasPrefix
        let path = funcPath(2, "w").appending(path: hasPrefix)
        XCTAssertEqual(
            try item.withArgsWithReturnWithError(arg1: 2, arg2: "w")
                .hasPrefix("w"),
            try path("w")(item)
        )
    }

    func testAsyncFuncPathAppending() async throws {
        let funcPath = |Item.withArgsWithReturnAsync

        // keyPath
        let result = await item.withArgsWithReturnAsync(arg1: 2, arg2: "w").count
        let expected = await item[funcPath: funcPath.count]((2, "w"))
        XCTAssertEqual(
            result,
            expected
        )

        // funcPath
        let hasPrefix = |String.hasPrefix
        let path = funcPath(2, "w").appending(path: hasPrefix)
        let result1 = await item.withArgsWithReturnAsync(arg1: 2, arg2: "w")
            .hasPrefix("w")
        let expected1 = await path("w")(item)
        XCTAssertEqual(
            result1,
            expected1
        )
    }

    func testAsyncThrowingFuncPathAppending() async throws {
        let funcPath = |Item.withArgsWithReturnWithErrorAsync

        // keyPath
        let result = try await item.withArgsWithReturnWithErrorAsync(arg1: 2, arg2: "w").count
        let expected = try await item[funcPath: funcPath.count]((2, "w"))
        XCTAssertEqual(
            result,
            expected
        )

        // funcPath
        let hasPrefix = |String.hasPrefix
        let path = funcPath(2, "w").appending(path: hasPrefix)
        let result1 = try await item.withArgsWithReturnWithErrorAsync(arg1: 2, arg2: "w")
            .hasPrefix("w")
        let expected1 = try await path("w")(item)
        XCTAssertEqual(
            result1,
            expected1
        )
    }
}
