import Foundation

do {
    try Build.performCommand(arguments: Array(CommandLine.arguments.dropFirst()))

    try BuildReadline().buildALL()
    try BuildGmp().buildALL()
    try BuildNettle().buildALL()
    try BuildGnutls().buildALL()
    try BuildSmbclient().buildALL()
} catch {
    print(error.localizedDescription)
    exit(0)
}


enum Library: String, CaseIterable {
    case libsmbclient, gnutls, gmp, nettle, readline
    var version: String {
        switch self {
        case .libsmbclient:
            return "samba-4.15.13"
        case .readline:
            return "readline-8.2"
        case .gnutls:
            return "3.8.3"
        case .nettle:
            return "nettle_3.9.1_release_20230601"
        case .gmp:
            return "v6.2.1"
        }
    }

    var url: String {
        switch self {
        case .libsmbclient:
            return "https://github.com/samba-team/samba"
        case .nettle:
            return "https://git.lysator.liu.se/nettle/nettle"
        case .gmp:
            return "https://github.com/alisw/GMP"
        case .readline:
            return "https://git.savannah.gnu.org/git/readline.git"
        case .gnutls:
            return "https://github.com/gnutls/gnutls"
        }
    }
}


private class BuildSmbclient: BaseBuild {

    init() {
        // // if use brew version python, you will need to install python-setuptools for distutils dependency error
        // if Utility.shell("brew list python-setuptools") == nil {
        //     Utility.shell("brew install python-setuptools")
        // }

        // install setuptools for distutils dependency
        if Utility.shell("python -m pip list|grep setuptools") == nil {
            Utility.shell("python -m pip install setuptools")
        }

        super.init(library: .libsmbclient)
    }

    override func wafPath() -> String {
        "buildtools/bin/waf"
    }

    override func environment(platform: PlatformType, arch: ArchType) -> [String: String] {
        var env = super.environment(platform: platform, arch: arch)
        let executableArchitecture = arch.executableArchitecture ?? "x86_64"
        let asn1DirectoryURL = URL.currentDirectory + ["../bin", executableArchitecture]
        env["PATH"] = asn1DirectoryURL.path + ":" + (directoryURL + "buildtools/bin").path + ":/Library/Frameworks/Python.framework/Versions/Current/bin:" + (env["PATH"] ?? "")
        env["PYTHONHASHSEED"] = "1"
        env["WAF_MAKE"] = "1"
        return env
    }

    override func wafBuildArg() -> [String] {
        ["--targets=smbclient"]
    }

    override func wafInstallArg() -> [String] {
        ["--targets=smbclient"]
    }

    override func build(platform: PlatformType, arch: ArchType) throws {
        try super.build(platform: platform, arch: arch)
        try FileManager.default.copyItem(at: directoryURL + "bin/default/source3/libsmb/libsmbclient.a", to: thinDir(platform: platform, arch: arch) + "lib/libsmbclient.a")
    }

    override func arguments(platform: PlatformType, arch: ArchType) -> [String] {
        [
            "--without-cluster-support",
            "--disable-rpath",
            "--without-ldap",
            "--without-pam",
            "--enable-fhs",
            "--without-winbind",
            "--without-ads",
            "--disable-avahi",
            "--disable-cups",
            "--without-gettext",
            "--without-ad-dc",
            "--without-acl-support",
            "--without-utmp",
            "--disable-iprint",
            "--nopyc",
            "--nopyo",
            "--disable-python",
            "--disable-symbol-versions",
            "--without-json",
            "--without-libarchive",
            "--without-regedit",
            "--without-lttng",
            "--without-gpgme",
            "--disable-cephfs",
            "--disable-glusterfs",
            "--without-syslog",
            "--without-quotas",
            "--bundled-libraries=ALL",
            "--with-static-modules=!vfs_snapper,ALL",
            "--nonshared-binary=smbtorture,smbd/smbd,client/smbclient",
            "--builtin-libraries=!smbclient,!smbd_base,!smbstatus,ALL",
            "--host=\(platform.host(arch: arch))",
            "--prefix=\(thinDir(platform: platform, arch: arch).path)",

            "--cross-compile",
            "--cross-answers=cross-answers.txt",
        ]
    }


    override func buildALL() throws {
        try super.buildALL()

        // copy headers
        let includeSourceDirectory = URL.currentDirectory + "../Sources/Libsmbclient.xcframework/ios-arm64/Libsmbclient.framework/Headers/samba-4.0"
        let includeDestDirectory = URL.currentDirectory + "../Sources/smbclient/include"
        print("Copy smbclient headers to path: \(includeDestDirectory.path)")
        try? FileManager.default.removeItem(at: includeDestDirectory)
        try? FileManager.default.copyItem(at: includeSourceDirectory, to: includeDestDirectory)
    }
}


private class BuildReadline: BaseBuild {
    init() {
        super.init(library: .readline)
    }

    // readline 只是在编译的时候需要用到。外面不需要用到
    override func frameworks() throws -> [String] {
        []
    }

    override func arguments(platform: PlatformType, arch: ArchType) -> [String] {
        [
            "--enable-static",
            "--disable-shared",
            "--host=\(platform.host(arch: arch))",
            "--prefix=\(thinDir(platform: platform, arch: arch).path)",
        ]
    }
}

private class BuildGmp: BaseBuild {
    init() {
        super.init(library: .gmp)
        // if Utility.shell("which makeinfo") == nil {
        //     Utility.shell("brew install texinfo")
        // }
    }

    override func arguments(platform: PlatformType, arch: ArchType) -> [String] {
        [
            "--disable-maintainer-mode",
            "--disable-assembly",
            "--with-pic",
            "--enable-static",
            "--disable-shared",
            "--disable-fast-install",
            "--host=\(platform.host(arch: arch))",
            "--prefix=\(thinDir(platform: platform, arch: arch).path)",
        ]
    }
}
private class BuildNettle: BaseBuild {
    init() {
        if Utility.shell("which autoconf") == nil {
            Utility.shell("brew install autoconf")
        }
        super.init(library: .nettle)
    }

    override func flagsDependencelibrarys() -> [Library] {
        [.gmp]
    }

    override func arguments(platform: PlatformType, arch: ArchType) -> [String] {
        [
            "--disable-assembler",
            "--disable-openssl",
            "--disable-gcov",
            "--disable-documentation",
            "--enable-pic",
            "--enable-static",
            "--disable-shared",
            "--disable-dependency-tracking",
            "--host=\(platform.host(arch: arch))",
            "--prefix=\(thinDir(platform: platform, arch: arch).path)",
//                arch == .arm64 || arch == .arm64e ? "--enable-arm-neon" : "--enable-x86-aesni",
        ]
    }

    override func frameworks() throws -> [String] {
        [library.rawValue, "hogweed"]
    }
}

private class BuildGnutls: BaseBuild {
    init() {
        if Utility.shell("which automake") == nil {
            Utility.shell("brew install automake")
        }
        if Utility.shell("which gtkdocize") == nil {
            Utility.shell("brew install gtk-doc")
        }
        if Utility.shell("which wget") == nil {
            Utility.shell("brew install wget")
        }
        if Utility.shell("brew list bison") == nil {
            Utility.shell("brew install bison")
        }
        if Utility.shell("which glibtoolize") == nil {
            Utility.shell("brew install libtool")
        }
        if Utility.shell("which asn1Parser") == nil {
            Utility.shell("brew install libtasn1")
        }
        super.init(library: .gnutls)
    }

    override func flagsDependencelibrarys() -> [Library] {
        [.gmp, .nettle]
    }

    override func ldFlags(platform: PlatformType, arch: ArchType) -> [String] {
        var ldFlags = super.ldFlags(platform: platform, arch: arch)
        ldFlags.append("-lhogweed")
        return ldFlags
    }

    override func environment(platform: PlatformType, arch: ArchType) -> [String: String] {
        var env = super.environment(platform: platform, arch: arch)
        // 需要bison的版本大于2.4,系统自带的/usr/bin/bison是 2.3
        env["PATH"] = "/usr/local/opt/bison/bin:/opt/homebrew/opt/bison/bin:" + (env["PATH"] ?? "")
        return env
    }

    override func configure(buildURL: URL, environ: [String: String], platform: PlatformType, arch: ArchType) throws {
        try super.configure(buildURL: buildURL, environ: environ, platform: platform, arch: arch)
        let path = directoryURL + "lib/accelerated/aarch64/Makefile.in"
        if let data = FileManager.default.contents(atPath: path.path), var str = String(data: data, encoding: .utf8) {
            str = str.replacingOccurrences(of: "AM_CCASFLAGS =", with: "#AM_CCASFLAGS=")
            try! str.write(toFile: path.path, atomically: true, encoding: .utf8)
        }
    }

    override func arguments(platform: PlatformType, arch: ArchType) -> [String] {
        [
            "--with-included-libtasn1",
            "--with-included-unistring",
            "--without-brotli",
            "--without-idn",
            "--without-p11-kit",
            "--without-zlib",
            "--without-zstd",
            "--enable-hardware-acceleration",
            "--disable-openssl-compatibility",
            "--disable-code-coverage",
            "--disable-doc",
            "--disable-maintainer-mode",
            "--disable-manpages",
            "--disable-nls",
            "--disable-rpath",
//                "--disable-tests",
            "--disable-tools",
            "--disable-full-test-suite",
            "--with-pic",
            "--enable-static",
            "--disable-shared",
            "--disable-fast-install",
            "--disable-dependency-tracking",
            "--host=\(platform.host(arch: arch))",
            "--prefix=\(thinDir(platform: platform, arch: arch).path)",
        ]
    }
}