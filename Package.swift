// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "SoundMeter",
    platforms: [
        .macOS(.v12)
    ],
    dependencies: [],
    targets: [
        .executableTarget(
            name: "SoundMeter",
            dependencies: [],
            path: "Sources"
        )
    ]
)