// swift-tools-version:5.8

import PackageDescription

let package = Package(
    name: "libsmbclient",
    platforms: [.macOS(.v10_15), .iOS(.v13), .tvOS(.v13)],
    products: [
        .library(
            name: "Libsmbclient",
            targets: ["Libsmbclient"]
        ),
        .library(
            name: "Libsmbclient-ios",
            targets: ["Libsmbclient-ios"]
        ),
        .library(
            name: "Libsmbclient-tvos",
            targets: ["Libsmbclient-tvos"]
        ),
        .library(
            name: "Libsmbclient_macos",
            targets: ["Libsmbclient_macos"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/mpvkit/gnutls-build.git", from: "3.8.3")
    ],
    targets: [
        .binaryTarget(
            name: "Libsmbclient",
            url: "\(Libsmbclient_url)",
            checksum: "\(Libsmbclient_checksum)"
        ),
        .binaryTarget(
            name: "Libsmbclient-ios",
            url: "\(Libsmbclient_ios_url)",
            checksum: "\(Libsmbclient_ios_checksum)"
        ),
        .binaryTarget(
            name: "Libsmbclient-tvos",
            url: "\(Libsmbclient_tvos_url)",
            checksum: "\(Libsmbclient_tvos_checksum)"
        ),
        .binaryTarget(
            name: "Libsmbclient_macos",
            url: "\(Libsmbclient_macos_url)",
            checksum: "\(Libsmbclient_macos_checksum)"
        )
    ]
)
