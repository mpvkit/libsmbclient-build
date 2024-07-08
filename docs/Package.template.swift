// swift-tools-version:5.8

import PackageDescription

let package = Package(
    name: "libsmbclient",
    products: [
        .library(
            name: "libsmbclient",
            type: .static,
            targets: ["smbclient"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/mpvkit/gnutls-build.git", from: "3.8.3")
    ],
    targets: [
        .target(
            name: "smbclient",
            dependencies: [
                "Libsmbclient"
            ]
        ),
        .binaryTarget(
            name: "Libsmbclient",
            url: "\(Libsmbclient_url)",
            checksum: "\(Libsmbclient_checksum)"
        )
    ]
)
