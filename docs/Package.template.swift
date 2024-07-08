// swift-tools-version:5.8

import PackageDescription

let package = Package(
    name: "libsmbclient",
    products: [
        .library(
            name: "libsmbclient",
            type: .static,
            targets: ["Libsmbclient"]
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
        )
    ]
)
