// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "androiduikit",
    products: [
        .library(name: "androiduikit", type: .dynamic, targets: ["androiduikittarget"]),
    ],
    dependencies: [
        .package(url: "git@github.com:PureSwift/Android.git", .revision("4d1c40b5e1e44314688e4635e544254763faec04"))
    ],
    targets: [
        .target(
            name: "androiduikittarget",
            dependencies: ["Android"],
            path: "Sources"
        ),
    ]
)
