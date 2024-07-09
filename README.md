# libsmbclient-build

build scripts for [libsmbclient](https://github.com/samba-team/samba)

## Installation

### Swift Package Manager

```
https://github.com/mpvkit/libsmbclient-build.git
```

## How to build

```bash
swift run --package-path scripts
```

or 

```bash
# deployment platform: macos,ios,tvos,maccatalyst
swift run --package-path scripts build platforms=ios,macos
```