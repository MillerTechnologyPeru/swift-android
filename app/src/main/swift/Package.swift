// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "swiftandroidsimple",
    products: [
        .library(name: "swiftandroidsimple", type: .dynamic, targets: ["swiftandroidtarget"]),
    ],
    dependencies: [
        .package(url: "git@github.com:PureSwift/Android.git", .revision("57893419bb642991ac189173785a60b672aee6f8"))
    ],
    targets: [
        .target(
            name: "swiftandroidtarget",
            dependencies: ["Android"],
            path: "Sources"
        ),
    ]
)
