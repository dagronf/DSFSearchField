//
//  DSFSearchField+SwiftUI.swift
//
//  Copyright © 2023 Darren Ford. All rights reserved.
//
//  MIT license
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
//  documentation files (the "Software"), to deal in the Software without restriction, including without limitation the
//  rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to
//  permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all copies or substantial
//  portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
//  WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS
//  OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
//  OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#if os(macOS) && canImport(SwiftUI)

//import AppKit
import SwiftUI

@available(macOS 10.15, *)
public extension DSFSearchField {
	/// A SwiftUI wrapper for DSFSearchField
	struct SwiftUI: NSViewRepresentable {
		public typealias NSViewType = DSFSearchField

		@Binding var text: String

		private var placeholderText: String?
		private var bezelStyle: NSTextField.BezelStyle?
		private var maximumRecents: Int?
		private var autosaveName: String?
		private var onSearchTermChange: ((String) -> Void)?
		private var onSearchTermSubmit: ((String) -> Void)?

		/// Initialize a DSFSearchField
		/// - Parameters:
		///   - text: The initial text for the control
		///   - placeholderText: The placeholder text to display in an empty search field
		///   - autosaveName: The autosave name
		///   - bezelStyle: The style of bezel to use on the search bar
		///   - onSearchTextChange: An optional callback for when the search term changes
		///   - onSearchTermSubmit: An optional callback for when the search field submits a value
		public init(
			text: Binding<String>,
			placeholderText: String? = nil,
			autosaveName: String? = nil,
			bezelStyle: NSTextField.BezelStyle? = nil,
			onSearchTermChange: ((String) -> Void)? = nil,
			onSearchTermSubmit: ((String) -> Void)? = nil
		) {
			self._text = text
			self.placeholderText = placeholderText
			self.bezelStyle = bezelStyle
			self.autosaveName = autosaveName
			self.onSearchTermChange = onSearchTermChange
			self.onSearchTermSubmit = onSearchTermSubmit
		}

		/// Called when the user 'submits' the text in the search control
		public func onUpdateSearchText(_ block: @escaping (String) -> Void) -> Self {
			var copy = self
			copy.onSearchTermChange = block
			return copy
		}

		/// Called when the user 'submits' the text in the search control
		public func onSubmitSearchText(_ block: @escaping (String) -> Void) -> Self {
			var copy = self
			copy.onSearchTermSubmit = block
			return copy
		}
	}
}

@available(macOS 10.15, *)
public extension DSFSearchField.SwiftUI {
	func makeNSView(context: Context) -> DSFSearchField {
		let searchBar = DSFSearchField(frame: .zero, recentsAutosaveName: self.autosaveName)

		if let bezelStyle = self.bezelStyle {
			searchBar.bezelStyle = bezelStyle
		}

		searchBar.placeholderString = self.placeholderText
		searchBar.searchTermChangeCallback = { newTerm in
			self.text = newTerm
			self.onSearchTermChange?(newTerm)
		}
		searchBar.searchSubmitCallback = { self.onSearchTermSubmit?($0) }

		// Default the control to scrolling text
		searchBar.cell?.wraps = false
		searchBar.cell?.isScrollable = true

		if let maximumRecents = self.maximumRecents {
			searchBar.maximumRecents = maximumRecents
		}

		return searchBar
	}

	func updateNSView(_ searchBar: DSFSearchField, context: Context) {
		searchBar.stringValue = text
		if let bezelStyle = self.bezelStyle {
			searchBar.bezelStyle = bezelStyle
		}

		if let maximumRecents = self.maximumRecents {
			searchBar.maximumRecents = maximumRecents
		}
	}
}

// MARK: - Modifiers

@available(macOS 10.15, *)
public extension DSFSearchField.SwiftUI {
	/// Set the bezel style for the control
	func bezelStyle(_ bezelStyle: NSTextField.BezelStyle) -> Self {
		modified(self) {
			$0.bezelStyle = bezelStyle
		}
	}

	/// Set the maximum number of recent values to display in the search dropdown
	///
	/// Asserts if `maximumRecents` is less than 1
	func maximumRecents(_ maximumRecents: Int) -> Self {
		assert(maximumRecents >= 1)
		return modified(self) {
			// Set the minimum number of recents to 1
			$0.maximumRecents = maximumRecents
		}
	}
}

#endif
