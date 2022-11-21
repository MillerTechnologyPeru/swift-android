// swift-tools-version: 5.7
import PackageDescription

let package = Package(
    name: "SwiftAndroidApp",
    platforms: [
        .macOS(.v12)
    ],
    products: [
        .library(
            name: "SwiftAndroidApp",
            type: .dynamic,
            targets: ["SwiftAndroidApp"]
        ),
    ],
    dependencies: [
        
    ],
    targets: [
        .target(
            name: "SwiftAndroidApp",
            dependencies: []
        ),
    ]
)
