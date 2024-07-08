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
    targets: [
        .target(
            name: "smbclient",
            dependencies: [
                "Libsmbclient",
                .Package(url: "https://github.com/mpvkit/gnutls-build.git", from: "3.8.3")
            ]
        ),
        .binaryTarget(
            name: "Libsmbclient",
            url: "https://github.com/mpvkit/libsmbclient-build/releases/download/0.0.0/Libsmbclient.xcframework.zip",
            checksum: "c4d9b7a7c0a8a2d13d3700100d14a9dee97f8113b81e69f8ae2be05a46735ed6"
        )
    ]
)
