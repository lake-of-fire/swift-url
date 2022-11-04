// swift-tools-version:5.5

// Copyright The swift-url Contributors.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import PackageDescription

let package = Package(
  name: "swift-url",
  products: [

    // 🧩 Core functionality.
    //    The WebURL type. You definitely want this.
    .library(name: "WebURL", targets: ["WebURL"]),

    // 🔗 Integration with swift-system.
    //    Adds WebURL <-> FilePath conversions.
    .library(name: "WebURLSystemExtras", targets: ["WebURLSystemExtras"]),

    // 🔗 Integration with Foundation.
    //    Adds WebURL <-> Foundation.URL conversions, and URLSession integration.
    .library(name: "WebURLFoundationExtras", targets: ["WebURLFoundationExtras"]),

    // 🧰 Support Libraries (internal use only).
    // =========================================
    // These libraries expose some convenient hooks for testing, benchmarking, and other tools
    // - either in this repo or at <https://github.com/karwa/swift-url-tools>.
    .library(name: "_WebURLIDNA", targets: ["IDNA"]),

  ],
  dependencies: [

    // 🔗 Integrations.
    // ================
    // WebURLSystemExtras supports swift-system 1.0+.
    .package(url: "https://github.com/apple/swift-system.git", .upToNextMajor(from: "1.0.0")),

  ],
  targets: [

    // 🗺 Unicode and IDNA.
    // ====================

    .target(
      name: "UnicodeDataStructures",
      swiftSettings: [.define("WEBURL_UNICODE_PARSE_N_PRINT", .when(configuration: .debug))]
    ),

    .target(
      name: "IDNA",
      dependencies: ["UnicodeDataStructures"]
    ),

    // 🌐 WebURL.
    // ==========

    .target(
      name: "WebURL",
      dependencies: ["IDNA"]
    ),

    // 🔗 WebURLSystemExtras.
    // ======================

    .target(
      name: "WebURLSystemExtras",
      dependencies: ["WebURL", .product(name: "SystemPackage", package: "swift-system")]
    ),

    // 🔗 WebURLFoundationExtras.
    // ==========================

    .target(
      name: "WebURLFoundationExtras",
      dependencies: ["WebURL"]
    ),
  ]
)
