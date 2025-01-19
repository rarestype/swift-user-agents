// swift-tools-version:6.0
import PackageDescription

let package:Package = .init(name: "swift-user-agents",
    platforms: [.macOS(.v15), .iOS(.v18), .tvOS(.v18), .visionOS(.v2), .watchOS(.v11)],
    products: [
        .library(name: "UA", targets: ["UA"]),
    ],
    dependencies: [
        .package(url: "https://github.com/tayloraswift/swift-grammar",
            from: "0.5.0"),
    ],
    targets: [
        .target(name: "UA",
            dependencies: [
                .product(name: "Grammar", package: "swift-grammar"),
            ]),

        .testTarget(name: "UATests",
            dependencies: [
                .target(name: "UA"),
            ]),
    ]
)

for target:PackageDescription.Target in package.targets
{
    {
        var settings:[PackageDescription.SwiftSetting] = $0 ?? []

        settings.append(.enableUpcomingFeature("ExistentialAny"))
        settings.append(.enableExperimentalFeature("StrictConcurrency"))

        $0 = settings
    } (&target.swiftSettings)
}
