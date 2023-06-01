//
//  DSFSearchField.swift
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

#if os(macOS)

import AppKit

/// A custom search field that provides a recent search list.
///
/// Fully definable through Interface Builder (set Autosave in the Attributes Inspector)
@objc public class DSFSearchField: NSSearchField {

	/// The search text convenience
	///
	/// * Bindable (using addObserver) for search text changes
	/// * Settable to change the name of the search text
	@objc public dynamic var searchTerm: String = "" {
		didSet {
			self.searchTermChangeCallback?(self.searchTerm)
		}
	}

	/// An (optional) block-based interface for receiving search field changes
	@objc public var searchTermChangeCallback: ((String) -> Void)? = nil

	/// Called when the user 'submits' the search (eg. presses return in the control)
	@objc public var searchSubmitCallback: ((String) -> Void)? = nil

	/// Create a search field
	/// - Parameters:
	///   - frameRect: The frame for the field
	///   - recentsAutosaveName: The autosave name
	@objc public init(frame frameRect: NSRect, recentsAutosaveName: NSSearchField.RecentsAutosaveName?) {
		super.init(frame: frameRect)
		self.recentsAutosaveName = recentsAutosaveName
		self.setup()
	}

	/// Creates a search field
	@objc public required init?(coder: NSCoder) {
		super.init(coder: coder)
		self.setup()
	}

	deinit {
		self.delegate = nil
		self.unbind(.value)
	}
}

// MARK: - delegate callbacks

extension DSFSearchField: NSSearchFieldDelegate {
	public func control(_ control: NSControl, textView: NSTextView, doCommandBy commandSelector: Selector) -> Bool {
		if commandSelector == #selector(NSResponder.insertNewline(_:)) {
			if let callback = self.searchSubmitCallback {
				callback(self.searchTerm)
			}
		}
		return false
	}
}

// MARK: - Private

private extension DSFSearchField {

	// Setup from init
	func setup() {
		self.searchMenuTemplate = self.createSearchesMenu()
		self.bind(.value, to: self, withKeyPath: #keyPath(searchTerm), options: nil)
		self.delegate = self
	}

	// Generate a searches menu
	func createSearchesMenu() -> NSMenu {
		let menu = NSMenu(title: Localizations.LCSMenuTitle)

		let recentTitleItem = menu.addItem(withTitle: Localizations.LCSMenuRecentTitle, action: nil, keyEquivalent: "")
		recentTitleItem.tag = Int(NSSearchField.recentsTitleMenuItemTag)

		let placeholder = menu.addItem(withTitle: Localizations.LCSMenuItemTitle, action: nil, keyEquivalent: "")
		placeholder.tag = Int(NSSearchField.recentsMenuItemTag)

		menu.addItem(NSMenuItem.separator())

		let clearItem = menu.addItem(withTitle: Localizations.LCSMenuClearRecentsTitle, action: nil, keyEquivalent: "")
		clearItem.tag = Int(NSSearchField.clearRecentsMenuItemTag)

		let emptyItem = menu.addItem(withTitle: Localizations.LCSMenuNoRecentsTitle, action: nil, keyEquivalent: "")
		emptyItem.tag = Int(NSSearchField.noRecentsMenuItemTag)

		return menu
	}
}

// MARK: - Localizations

private extension DSFSearchField {
	// Localized strings
	enum Localizations {
		static let LCSMenuTitle = NSLocalizedString("Recent", comment: "Menu title for the recent searches menu")

		static let LCSMenuItemTitle = NSLocalizedString("Item", comment: "")
		static let LCSMenuClearRecentsTitle = NSLocalizedString("Clear Recent Searches", comment: "Menu item to clear all recent items from the search recent menu")

		static let LCSMenuRecentTitle = NSLocalizedString("Recent Searches", comment: "Title presented for the available recent searches menu when recent searches are available")
		static let LCSMenuNoRecentsTitle = NSLocalizedString("No Recent Search", comment: "Title stating that there are no recent searches in the search menu")
	}
}

#endif
