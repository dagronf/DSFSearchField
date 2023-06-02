// swift-tools-version: 5.4

import PackageDescription

let package = Package(
	name: "DSFSearchField",
	defaultLocalization: "en",
	platforms: [
		.macOS(.v10_13)
	],
	products: [
		.library(
			name: "DSFSearchField",
			targets: ["DSFSearchField"]),
	],
	dependencies: [
	],
	targets: [
		.target(
			name: "DSFSearchField",
			dependencies: []),
		.testTarget(
			name: "DSFSearchFieldTests",
			dependencies: ["DSFSearchField"]),
	]
)
