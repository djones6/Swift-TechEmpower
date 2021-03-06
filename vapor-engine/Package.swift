import PackageDescription

let package = Package(
    name: "VaporEngineApp",
    dependencies: [
        .Package(url: "https://github.com/vapor/engine.git", majorVersion: 1, minor: 0),
    ],
    exclude: [
        "Config",
        "Database",
        "Localization",
        "Public",
        "Resources",
        "Tests",
    ]
)
