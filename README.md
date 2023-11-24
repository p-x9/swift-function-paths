# FunctionPaths

functionPath is like a function version of keyPath.

- Combine functions in series like a pipeline.
- Easily specify operations with higher-order functions

<!-- # Badges -->

[![Github issues](https://img.shields.io/github/issues/p-x9/c)](https://github.com/p-x9/swift-function-paths/issues)
[![Github forks](https://img.shields.io/github/forks/p-x9/swift-function-paths)](https://github.com/p-x9/swift-function-paths/network/members)
[![Github stars](https://img.shields.io/github/stars/p-x9/swift-function-paths)](https://github.com/p-x9/swift-function-paths/stargazers)
[![Github top language](https://img.shields.io/github/languages/top/p-x9/swift-function-paths)](https://github.com/p-x9/swift-function-paths/)

## Usage

### Obtaining FunctionPath

In `functionPath`, the "|" operator is used instead of the "\\" operator used in keyPath.

Let's consider the following structure:

```swift
struct Item {
    let title: String
    let value: Int

    func printInfo(at date: Date) {
        print(description(for: date))
    }

    func description(for date: Date) -> String {
        return "[\(date)] \(title), \(value), "
    }
}
```

In this scenario, obtaining the functionPath is done as follows:

```swift
let printInfo = |Item.printInfo // FunctionPath<Item, Date, Void>
let description = |Item.description // FunctionPath<Item, Date, String>
```

### About FunctionPathWithInput

`FunctionPathWithInput` is specified as arguments to functionPath.

Convert from functionPath to the following

```swift
let printCurrentInfo = printInfo(Date()) // FunctionPathWithInput<Item, Void>
let currentDescription = description(Date()) // FunctionPathWithInput<Item, String>
```

Since `@autoclosure` attribute is specified as the argument, evaluation is performed when the function is actually executed.

### Excute function with function path

There are several ways to call a function using functionPath.

```swift
let item = Item(title: "hello", value: 12345)

// with subscript
item[funcPath: printCurrentInfo] // FunctionPathWithInput
item[funcPath: printInfo](Date()) // FunctionPath

// callAsFunction
printCurrentInfo(item) // FunctionPathWithInput
printInfo(item)(Date()) // FunctionPath
```

### Combining functionPaths

A functionPath can combine several into one.
The return type of the first functionPath must match the root type of the other functionPath.

The following example retrieves the data for the description directly from the item.

```swift
let utf8Data = (|String.data)(.utf8, false)

let descriptionData = description.appending(utf8Data) // FunctionPath<Item, Date, Data>

let currentDescriptionData = currentDescription.appending(utf8Data) // FunctionPathWithInput<Item, Data>

// Same as below
let descriptionString = item.description(for: Date())
let data = descriptionString.data(using: .utf8)
```

### Relationship with keyPath

functionPath can also be used in conjunction with KeyPath.

#### Appending KeyPath

The following example adds a keyPath to the functionPath named `currentDescription`.
`currentDescription` returns a String, so we add `\String.count` to get the number of characters.

```swift
let currentDescriptionCount = currentDescription.appending(\.count)
/* or */
let currentDescriptionCount = currentDescription.count
```

#### Convert KeyPath to FunctionPath

keyPath can be converted to functionPath.

```swift
let funcPath = |\String.count
```

### Throwing / Async / Async Throwing Function

Normal functions, throwing functions, and asynchronous functions are each managed in a separate functionPath type.

|  function  |  function path  |  function path with input  |
| :----: | :----: | :----: |
|  normal  |  FunctionPath  |  FunctionPathWithInput  |
|  throwing  |  ThrowingFunctionPath  |  ThrowingFunctionPathWithInput |
|  async  |  AsyncFunctionPath  |  AsyncFunctionPathWithInput  |
|  async throwing  | AsyncThrowingFunctionPath  |  AsyncThrowingFunctionPathWithInput |

#### convert

The following order of conversion is possible for the higher level ones.

```txt
FunctionPath -> ThrowingFunctionPath -> AsyncThrowingFunctionPath
             -> AsyncFunctionPath    -> AsyncThrowingFunctionPath
```

```txt
FunctionPathWithInput -> ThrowingFunctionPathWithInput -> AsyncThrowingFunctionPathWithInput
                      -> AsyncFunctionPathWithInput    -> AsyncThrowingFunctionPathWithInput
```

```swift
let functionPath = |Item.printInfo // FunctionPath<Item, Date, Void>
let asyncFunctionPath = AsyncFunctionPath(functionPath)
```

## License

FunctionPaths is released under the MIT License. See [LICENSE](./LICENSE)
