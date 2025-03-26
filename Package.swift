
// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "amad_sdk_ios",
    defaultLocalization: "es",
    platforms: [.iOS(.v18)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "amad_sdk_ios",
            targets: ["amad_sdk_ios"]),
    ],
    dependencies: [
           .package(url: "https://github.com/airbnb/lottie-ios", from: "4.3.0"),
           .package(url: "https://github.com/auth0/JWTDecode.swift", from: "3.2.0")
       ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "amad_sdk_ios",
            dependencies: [
                            .product(name: "Lottie", package: "lottie-ios"),
                            .product(name: "JWTDecode", package: "JWTDecode.swift")
                        ],
            resources: [
                           .process("resources")  // Aquí agregamos el recurso JSON
                       ]
        ),
        

    ]
)
