// swift-tools-version:6.0
import PackageDescription

let package: Package = .init(
    name: "swift-user-agents",
    platforms: [.macOS(.v15), .iOS(.v18), .tvOS(.v18), .visionOS(.v2), .watchOS(.v11)],
    products: [
        .library(name: "CommonAgents", targets: ["CommonAgents"]),
        .library(name: "UA", targets: ["UA"]),
    ],
    dependencies: [
        .package(url: "https://github.com/ordo-one/dollup", from: "1.0.1"),
        .package(url: "https://github.com/rarestype/gram", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "CommonAgents",
            dependencies: [
                .target(name: "UA"),
            ]
        ),

        .target(
            name: "UA",
            dependencies: [
                .product(name: "Grammar", package: "gram"),
            ]
        ),


        .testTarget(
            name: "CommonAgentTests",
            dependencies: [
                .target(name: "CommonAgents"),
            ]
        ),

        .testTarget(
            name: "UATests",
            dependencies: [
                .target(name: "UA"),
            ]
        ),
    ]
)

for target: Target in package.targets {
    {
        var settings: [ SwiftSetting] = $0 ?? []

        settings.append(.enableUpcomingFeature("ExistentialAny"))
        settings.append(.enableExperimentalFeature("StrictConcurrency"))

        $0 = settings
    } (&target.swiftSettings)
}
