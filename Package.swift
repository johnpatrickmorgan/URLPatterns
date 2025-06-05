// swift-tools-version:6.0

import PackageDescription

let package = Package(
  name: "URLPatterns",
  products: [
    .library(name: "URLPatterns", targets: ["URLPatterns"]),
  ],
  dependencies: [],
  targets: [
    .target(
      name: "URLPatterns",
      dependencies: []
    ),
    .testTarget(
      name: "URLPatternsTests",
      dependencies: ["URLPatterns"]
    ),
  ]
)
