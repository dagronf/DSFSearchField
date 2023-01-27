//
//  ViewController.swift
//  DSFSearchField Demo
//
//  Created by Darren Ford on 26/10/20.
//

import Cocoa

import DSFSearchField

class ViewController: NSViewController {

	@IBOutlet weak var primarySearchField: DSFSearchField!
	@IBOutlet weak var searchField: DSFSearchField!
	@IBOutlet weak var settableSearchField: DSFSearchField!

	override func viewDidLoad() {
		super.viewDidLoad()

		// Do any additional setup after loading the view.

		self.primarySearchField.searchTermChangeCallback = { newSearchTerm in
			Swift.print("primary UPDATE: search term is `\(newSearchTerm)`")
		}

		self.primarySearchField.searchSubmitCallback = { newSearchTerm in
			Swift.print("primary SUBMIT: search term is `\(newSearchTerm)`")
		}
	}
	
	override var representedObject: Any? {
		didSet {
		// Update the view, if already loaded.
		}
	}

	@IBAction func didSearch(_ sender: DSFSearchField) {
		Swift.print("Search term = \(sender.searchTerm)")
	}

	@IBAction func textDidChange(_ sender: NSTextField) {
		settableSearchField.searchTerm = sender.stringValue
	}
}

