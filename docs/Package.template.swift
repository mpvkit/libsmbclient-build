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
                "Libssl", "Libcrypto"
            ]
        ),
        .binaryTarget(
            name: "gmp",
            url: "\(gmp_url)",
            checksum: "\(gmp_checksum)"
        ),
        .binaryTarget(
            name: "nettle",
            url: "\(nettle_url)",
            checksum: "\(nettle_checksum)"
        ),
        .binaryTarget(
            name: "hogweed",
            url: "\(hogweed_url)",
            checksum: "\(hogweed_checksum)"
        ),
        .binaryTarget(
            name: "gnutls",
            url: "\(gnutls_url)",
            checksum: "\(gnutls_checksum)"
        ),
        .binaryTarget(
            name: "Libsmbclient",
            url: "\(Libsmbclient_url)",
            checksum: "\(Libsmbclient_checksum)"
        )
    ]
)
