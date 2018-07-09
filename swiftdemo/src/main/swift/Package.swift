// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "swiftdemo",
    products: [
        .library(name: "swiftdemo", type: .dynamic, targets: ["swiftdemotarget"]),
    ],
    dependencies: [
        .package(url: "git@github.com:PureSwift/Android.git", .revision("171ef643e8cd44210b45e1ebbc85805233dac5d2"))
    ],
    targets: [
        .target(
            name: "swiftdemotarget",
            dependencies: ["Android"],
            path: "Sources"
        ),
    ]
)
