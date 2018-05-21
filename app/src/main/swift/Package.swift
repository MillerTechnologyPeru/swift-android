// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "swiftandroid",
    products: [
        .library(name: "swiftandroid", type: .dynamic, targets: ["swiftandroid"]),
    ],
    dependencies: [
        .package(url: "https://github.com/SwiftJava/java_swift.git", from: "2.3.2"),
        .package(url: "https://github.com/SwiftJava/java_util.git", from: "2.3.2"),
        .package(url: "https://github.com/PureSwift/Bluetooth.git", from: "1.8.1"),
        .package(url: "https://github.com/PureSwift/JNI.git", from: "1.0.3")

    ],
    targets: [
        .target(
            name: "swiftandroid",
            dependencies: ["java_swift", "java_util", "Bluetooth", "JNI"],
            path: "Sources"
        ),
    ]
)
