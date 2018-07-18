// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "androiduikit",
    products: [
        .library(name: "androiduikit", type: .dynamic, targets: ["androiduikittarget"]),
    ],
    dependencies: [
        .package(url: "git@github.com:PureSwift/Android.git", .revision("ce74db0cb72774e647fa5c282026c44eb3f73f2c"))
    ],
    targets: [
        .target(
            name: "androiduikittarget",
            dependencies: ["Android"],
            path: "Sources"
        ),
    ]
)
