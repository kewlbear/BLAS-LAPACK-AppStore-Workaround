// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "BLAS-LAPACK-AppStore-Workaround",
    products: [
        .library(
            name: "BLAS-LAPACK-AppStore-Workaround",
            targets: ["BLAS-LAPACK-AppStore-Workaround"]),
    ],
    targets: [
        .target(
            name: "BLAS-LAPACK-AppStore-Workaround",
            dependencies: []),
        .testTarget(
            name: "BLAS-LAPACK-AppStore-WorkaroundTests",
            dependencies: ["BLAS-LAPACK-AppStore-Workaround"]),
    ]
)
