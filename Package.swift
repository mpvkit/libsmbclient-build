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
            url: "https://github.com/mpvkit/libsmbclient-build/releases/download/4.15.13/Libsmbclient.xcframework.zip",
            checksum: "699800a22d7b457a8baf8d334ddf2623fda983d9084e6c26a57fea1be24c7168"
        )
    ]
)
