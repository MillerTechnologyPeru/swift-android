// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "swiftdemo",
    products: [
        .library(name: "swiftdemo", type: .dynamic, targets: ["swiftdemotarget"]),
    ],
    dependencies: [
        .package(url: "git@github.com:PureSwift/Android.git", .revision("0e3a46c8923256bdbf4b89fa2a95d252d27db7cb"))
    ],
    targets: [
        .target(
            name: "swiftdemotarget",
            dependencies: ["Android"],
            path: "Sources"
        ),
    ]
)
