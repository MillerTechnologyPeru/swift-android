// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "androiduikit",
    products: [
        .library(name: "androiduikit", type: .dynamic, targets: ["androiduikittarget"]),
    ],
    dependencies: [
        .package(url: "git@github.com:PureSwift/Android.git", .revision("69b779c5eccb6f87f38682e876b93c260081adf5"))
    ],
    targets: [
        .target(
            name: "androiduikittarget",
            dependencies: ["Android"],
            path: "Sources"
        ),
    ]
)
