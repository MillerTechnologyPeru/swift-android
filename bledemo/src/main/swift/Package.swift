// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "swiftandroid",
    products: [
        .library(name: "swiftandroid", type: .dynamic, targets: ["swiftandroid"]),
    ],
    dependencies: [
        .package(url: "git@github.com:PureSwift/Android.git", .revision("d1cb9387b333e2d33c2c609be04d2ef9e153312e"))
    ],
    targets: [
        .target(
            name: "swiftandroid",
            dependencies: ["Android"],
            path: "Sources"
        ),
    ]
)
