// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "swiftdemo",
    products: [
        .library(name: "swiftdemo", type: .dynamic, targets: ["swiftdemotarget"]),
    ],
    dependencies: [
        .package(url: "git@github.com:PureSwift/Android.git", .branch("master")),
        .package(url: "git@github.com:PureSwift/GATT.git", from: "2.0.0")
    ],
    targets: [
        .target(
            name: "swiftdemotarget",
            dependencies: ["Android", "GATT"],
            path: "Sources"
        ),
    ]
)
