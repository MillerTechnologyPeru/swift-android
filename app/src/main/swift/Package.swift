// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "swiftandroid",
    products: [
        .library(name: "swiftandroid", type: .dynamic, targets: ["swiftandroid"]),
    ],
    dependencies: [
        .package(url: "git@github.com:PureSwift/Android.git", .revision("e1620420025a5d561db0104e4a73432bee5a1362"))
    ],
    targets: [
        .target(
            name: "swiftandroid",
            dependencies: ["Android"],
            path: "Sources"
        ),
    ]
)
