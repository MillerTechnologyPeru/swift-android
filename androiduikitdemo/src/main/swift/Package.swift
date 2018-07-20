// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "androiduikit",
    products: [
        .library(name: "androiduikit", type: .dynamic, targets: ["androiduikittarget"]),
    ],
    dependencies: [
        .package(url: "git@github.com:PureSwift/Android.git", .branch("master"))
    ],
    targets: [
        .target(
            name: "androiduikittarget",
            dependencies: ["Android"],
            path: "Sources"
        ),
    ]
)
