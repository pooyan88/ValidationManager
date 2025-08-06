// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "ValidationManager",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "ValidationManager",
            targets: ["ValidationManager"]
        ),
    ],
    targets: [
        .target(
            name: "ValidationManager",
            dependencies: [],
            path: "Sources/ValidationManager",
            resources: [
                .process("Resources") // <- Include Banks.json or other files here
            ]
        ),
        .testTarget(
            name: "ValidationManagerTests",
            dependencies: ["ValidationManager"],
            path: "Tests/ValidationManagerTests"
        ),
    ]
)
