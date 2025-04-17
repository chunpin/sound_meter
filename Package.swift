// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "SoundMeter",
    platforms: [
        .macOS(.v12)
    ],
    products: [
        .executable(
            name: "SoundMeter",
            targets: ["SoundMeter"]
        )
    ],
    dependencies: [],
    targets: [
        .executableTarget(
            name: "SoundMeter",
            dependencies: [],
            path: "Sources",
            resources: [
                .process("Assets.xcassets")
            ],
            swiftSettings: [
                .define("APP_BUNDLE")
            ]
        )
    ]
)