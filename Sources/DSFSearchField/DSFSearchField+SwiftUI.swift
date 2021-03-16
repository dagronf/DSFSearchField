//
//  DSFSearchField+SwiftUI.swift
//
//  Created by Darren Ford on 16/3/21.
//  Copyright © 2021 Darren Ford. All rights reserved.
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

#if os(macOS)

#if canImport(SwiftUI)

import AppKit
import SwiftUI

@available(macOS 10.15, *)
@available(iOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
public extension DSFSearchField {
	/// A SwiftUI wrapper for DSFSearchField
	struct SwiftUI: NSViewRepresentable {
		public typealias NSViewType = DSFSearchField

		@Binding var text: String

		let placeholderText: String?
		let autosaveName: String?
		let onSearchTermChange: ((String) -> Void)?

		/// Initialize a DSFSearchField
		/// - Parameters:
		///   - text: The initial text for the control
		///   - placeholderText: The placeholder text to display in an empty search field
		///   - autosaveName: The autosave name
		///   - onSearchTextChange: An optional callback for when the search term changes
		public init(text: Binding<String>,
			  placeholderText: String? = nil,
			  autosaveName: String? = nil,
			  onSearchTermChange: ((String) -> Void)? = nil)
		{
			self._text = text
			self.placeholderText = placeholderText
			self.autosaveName = autosaveName
			self.onSearchTermChange = onSearchTermChange
		}
	}
}

@available(macOS 10.15, *)
@available(iOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
public extension DSFSearchField.SwiftUI {
	func makeNSView(context _: NSViewRepresentableContext<DSFSearchField.SwiftUI>) -> DSFSearchField {
		let searchBar = DSFSearchField(frame: .zero, recentsAutosaveName: self.autosaveName)
		searchBar.placeholderString = self.placeholderText
		searchBar.searchTermChangeCallback = { newTerm in
			self.text = newTerm
			self.onSearchTermChange?(newTerm)
		}
		return searchBar
	}

	func updateNSView(_ nsView: DSFSearchField,
							context _: NSViewRepresentableContext<DSFSearchField.SwiftUI>)
	{
		nsView.stringValue = text
	}
}

#endif

#endif
