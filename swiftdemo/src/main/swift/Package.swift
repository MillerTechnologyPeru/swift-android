// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "swiftdemo",
    products: [
        .library(name: "swiftdemo", type: .dynamic, targets: ["swiftdemotarget"]),
    ],
    dependencies: [
        .package(url: "git@github.com:PureSwift/Android.git", .revision("bdced9c644933cf151c61712a29e32160af79e19"))
    ],
    targets: [
        .target(
            name: "swiftdemotarget",
            dependencies: ["Android"],
            path: "Sources"
        ),
    ]
)
