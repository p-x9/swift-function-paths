import Foundation
import FunctionPaths

struct Item {
    let title: String
    let value: Int

    func description(for date: Date) -> String {
        "\(title): \(value) (\(date.timeIntervalSince1970))"
    }

    func vv() -> String { title }

    func printTitle() {
        print(title)
    }
}

extension Item: FuncPathAccessable {}

let items: [Item] = [
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

let item = Item(title: "hello", value: 5)


// MARK: - Func Path `description`
print("\n-------------------------------------------")
let funcPath = |Item.description


let description = item[funcPath: funcPath](Date())
print(description)


let descriptions = items.map(funcPath(Date()))
print(descriptions.joined(separator: "\n"))

// MARK: - FuncPath `description` contains "title3"
print("\n-------------------------------------------")
let funcPathWithInputs: FunctionPathWithInput<Item, String> = funcPath(Date())
let containsPath = funcPathWithInputs.appending(path: |String.contains)("title3")
let contains = items.map(containsPath)
print(contains)

// MARK: - FuncPath `description` length(count)
print("\n-------------------------------------------")
let countPath = funcPathWithInputs.count
let counts = items.map(countPath)
print(counts)

// MARK: - funcPath No arguments
print("\n-------------------------------------------")
let funcPath2 = |Item.printTitle
items.forEach(funcPath2)


// MARK: - Enum (appending KeyPath to FunctionPath)
print("\n-------------------------------------------")
enum A: String, CaseIterable, FuncPathAccessable {
    case a = "Hello form enum A.a",b,c

    func des(_ date: Date) -> String {
        "\(self), \(date)"
    }
}
let path: FunctionPathWithInput<A, A> = |.self
//let path = |A.self
let rawValuePath = path.rawValue
print(A.a[funcPath: rawValuePath])


// MARK: - Convert KeyPath to FunctionPath
print("\n-------------------------------------------")
let count = |\String.count
print(count("ajsfpoajsfp"))

