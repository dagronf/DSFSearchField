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

#if os(macOS) && canImport(SwiftUI)

import AppKit
import SwiftUI

@available(macOS 10.15, *)
public extension DSFSearchField {
	/// A SwiftUI wrapper for DSFSearchField
	struct SwiftUI: NSViewRepresentable {
		public typealias NSViewType = DSFSearchField

		@Binding var text: String

		let placeholderText: String?
		let autosaveName: String?
		let onSearchTermChange: ((String) -> Void)?
		let onSearchTermSubmit: ((String) -> Void)?

		/// Initialize a DSFSearchField
		/// - Parameters:
		///   - text: The initial text for the control
		///   - placeholderText: The placeholder text to display in an empty search field
		///   - autosaveName: The autosave name
		///   - onSearchTextChange: An optional callback for when the search term changes
		///   - onSearchTermSubmit: An optional callback for when the search field submits a value
		public init(
			text: Binding<String>,
			placeholderText: String? = nil,
			autosaveName: String? = nil,
			onSearchTermChange: ((String) -> Void)? = nil,
			onSearchTermSubmit: ((String) -> Void)? = nil
		) {
			self._text = text
			self.placeholderText = placeholderText
			self.autosaveName = autosaveName
			self.onSearchTermChange = onSearchTermChange
			self.onSearchTermSubmit = onSearchTermSubmit
		}

		/// Called when the user 'submits' the text in the search control
		public func onUpdateSearchText(_ block: @escaping (String) -> Void) -> Self {
			return DSFSearchField.SwiftUI(
				text: self.$text,
				placeholderText: self.placeholderText,
				autosaveName: self.autosaveName,
				onSearchTermChange: block,
				onSearchTermSubmit: self.onSearchTermChange
			)
		}

		/// Called when the user 'submits' the text in the search control
		public func onSubmitSearchText(_ block: @escaping (String) -> Void) -> Self {
			return DSFSearchField.SwiftUI(
				text: self.$text,
				placeholderText: self.placeholderText,
				autosaveName: self.autosaveName,
				onSearchTermChange: self.onSearchTermChange,
				onSearchTermSubmit: block
			)
		}
	}
}

@available(macOS 10.15, *)
public extension DSFSearchField.SwiftUI {
	func makeNSView(
		context _: NSViewRepresentableContext<DSFSearchField.SwiftUI>
	) -> DSFSearchField {
		let searchBar = DSFSearchField(frame: .zero, recentsAutosaveName: self.autosaveName)
		searchBar.placeholderString = self.placeholderText
		searchBar.searchTermChangeCallback = { newTerm in
			self.text = newTerm
			self.onSearchTermChange?(newTerm)
		}
		searchBar.searchSubmitCallback = { self.onSearchTermSubmit?($0) }
		return searchBar
	}

	func updateNSView(
		_ nsView: DSFSearchField,
		context _: NSViewRepresentableContext<DSFSearchField.SwiftUI>
	) {
		nsView.stringValue = text
	}
}

//@available(macOS 10.15, *)
//struct GreenButtonStyle: ViewModifier {
//	 func body(content: Content) -> some View {
//		  return content
//		  .foregroundColor(.white)
//		  .background(Color.green)
//		  .border(Color(red: 7/255,
//							 green: 171/255,
//							 blue: 67/255),
//					 width: 5)
//	 }
//}

#endif
