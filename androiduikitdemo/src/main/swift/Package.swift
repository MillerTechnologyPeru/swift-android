// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "androiduikitdemo",
    products: [
        .library(name: "androiduikitdemo", type: .dynamic, targets: ["androiduikittarget"]),
    ],
    dependencies: [
        .package(url: "git@github.com:PureSwift/AndroidUIKit.git", .branch("master")),
        .package(url: "git@github.com:PureSwift/AndroidBluetooth.git", .branch("master"))
    ],
    targets: [
        .target(
            name: "androiduikittarget",
            dependencies: ["AndroidUIKit", "AndroidBluetooth"],
            path: "Sources"
        ),
    ]
)
