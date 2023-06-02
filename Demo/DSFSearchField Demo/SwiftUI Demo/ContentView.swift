//
//  ContentView.swift
//  SwiftUI Demo
//
//  Created by Darren Ford on 27/1/2023.
//

import SwiftUI
import DSFSearchField

struct ContentView: View {
	@State var search1: String = ""

	@State var submittedText: String = ""

	var body: some View {
		VStack(alignment: .leading, spacing: 8) {
			GroupBox("Search operation") {
				VStack(alignment: .leading, spacing: 8) {
					HStack {
						Text("Search ->")
						DSFSearchField.SwiftUI(
							text: $search1,
							autosaveName: "Search1"
						)
						//.bezel(.roundedBezel)
						.onUpdateSearchText { newValue in
							Swift.print("Update with new value -> \(newValue)")
						}
						.onSubmitSearchText { newValue in
							submittedText = newValue
						}
					}
					HStack {
						Text("Updated search string:")
						Text(search1)
					}
					HStack {
						Text("Submitted search string:")
						Text(submittedText)
					}
				}
				.padding(8)
			}

			GroupBox("Styles") {
				HStack {
					VStack(alignment: .leading) {
						Text("Rounded").bold()
						DSFSearchField.SwiftUI(
							text: .constant("")
						)
						.bezel(.roundedBezel)
					}

					VStack(alignment: .leading) {
						Text("Rounded").bold()
						DSFSearchField.SwiftUI(
							text: .constant("")
						)
						.bezel(.squareBezel)
					}
				}
			}
		}
		.padding()
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
