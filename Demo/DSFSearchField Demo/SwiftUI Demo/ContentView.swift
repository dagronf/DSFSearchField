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
	var body: some View {
		HStack {
			Text("Search ->")
			DSFSearchField.SwiftUI(
				text: $search1,
				autosaveName: "Search1"
			)
			Text(search1)
		}
		.padding()
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
