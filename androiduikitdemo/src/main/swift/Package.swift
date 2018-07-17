// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "androiduikit",
    products: [
        .library(name: "androiduikit", type: .dynamic, targets: ["androiduikittarget"]),
    ],
    dependencies: [
        .package(url: "git@github.com:PureSwift/Android.git", .revision("dfafd76df909aa04a1efd7f8e94442b3b7c255bd"))
    ],
    targets: [
        .target(
            name: "androiduikittarget",
            dependencies: ["Android"],
            path: "Sources"
        ),
    ]
)
