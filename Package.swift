// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "FunctionPaths",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13),
        .tvOS(.v13),
        .watchOS(.v6),
        .macCatalyst(.v13)
    ],
    products: [
        .library(
            name: "FunctionPaths",
            targets: ["FunctionPaths"]
        )
    ],
    dependencies: [],
    targets: [
        .executableTarget(
            name: "Exec",
            dependencies: [
                "FunctionPaths"
            ]
        ),
        .target(
            name: "FunctionPaths",
            dependencies: []
        ),
        .testTarget(
            name: "FunctionPathsTests",
            dependencies: [
                "FunctionPaths",
            ]
        ),
    ]
)
