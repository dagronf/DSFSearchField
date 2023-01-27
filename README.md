# DSFSearchField

![](https://github.com/dagronf/dagronf.github.io/blob/master/art/projects/DSFSearchField/screenshot.png?raw=true)

A simple NSSearchField with a localizable, managed recent searches menu and SwiftUI support.

![](https://img.shields.io/github/v/tag/dagronf/DSFSearchField) ![](https://img.shields.io/badge/macOS-10.11+-red) ![](https://img.shields.io/badge/Swift-5.0-orange.svg)
![](https://img.shields.io/badge/License-MIT-lightgrey) [![](https://img.shields.io/badge/spm-compatible-brightgreen.svg?style=flat)](https://swift.org/package-manager)

## Why

`NSSearchField` has a wonderful built-in mechanism for handling recents list which requires the developer to provide a menu to provide the recents list.  This class automatically provides a suitable localizable menu structure.

`DSFSearchField` inherits from `NSSearchField` so search delegates, actions etc. all work as expected.

## Installation

Note that currently to support localization you'll need to use the 'Direct' method below until Swift tool version 5.3 becomes more pervasive (it supports embedding localizations within modules)

### Swift Package Manager

Add `https://github.com/dagronf/DSFSearchField` to your project.

### Direct

Copy `DSFSearchField.swift` (and `DSFSearchField+SwiftUI.swift`) if you want SwiftUI support) to your project.

## Usage

### Via Interface Builder

* Add a new `NSSearchField` using Interface Builder, then change the class type to `DSFSearchField`.
* If you want to save the recent searches list, set `Autosave` in the Attributes Inspector of Interface Builder to a unique string for your project.

### Programatically

```swift
let searchField = DSFSearchField(frame: rect, recentsAutosaveName: "primary-search")
```

## Conveniences

### Search text change callback

This is called whenever the text changes within the search field.

```swift
   searchField.searchTermChangeCallback = { [weak self] newSearchTerm in
      // Do something with 'newSearchTerm'
      ...
   }
```

### Submit callback

This is called when the user presses 'return' in the search field.

```swift
   searchField.searchSubmitCallback = { [weak self] newSearchTerm in
      // Do something with 'newSearchTerm'
      ...
   }
```

### Simple searchTerm interface

You can set the search text using `stringValue`, but I personally find this scans badly when I'm trying to read and understand code. This class provides an additional property `searchTerm` more descriptive property name. This property is bindable and settable.

Simple setting of the search term

```swift
searchField.searchTerm = "cats"
```

Bindable observation of the search term.

```swift
searchField.addObserver(
   self, 
   forKeyPath: #keyPath(DSFSearchField.searchTerm), 
   options: [.new], 
   context: nil)
```

## SwiftUI

`DSFSearchField` provides a basic SwiftUI interface to the search control.

```swift
DSFSearchField.SwiftUI(
   text: $searchText, 
   placeholderText: "Search for colors…",
   autosaveName: "SystemColorsSearchField"
)
```

### Available view modifiers

**Note:** Unfortunately, I could not figure out how to hook into SwiftUI's `onSubmit` view modifier (and it appears that
the required `Environment` values have not been made visible to the public. So that means that the default `onSubmit`
view modifier that SwiftUI provides will not be called.

#### `onUpdateSearchText`

Provide a block that gets called when the search text changes.

```swift
DSFSearchField.SwiftUI(...)
   .onUpdateSearchText { newValue in
      Swift.print("Update with new value -> \(newValue)")
   }
```

#### `onSubmitSearchText`

Provide a block that gets called when the search text is submitted (the user presses the return key in the field)

```swift
DSFSearchField.SwiftUI(...)
   .onSubmitSearchText { newValue in
      Swift.print("Update with new value -> \(newValue)")
   }
```

### Example

```swift
var body: some View {
   DSFSearchField.SwiftUI(
      text: $search1,
      autosaveName: "Search1"
   )
   .onUpdateSearchText { newValue in
      Swift.print("Update with new value -> \(newValue)")
   }
   .onSubmitSearchText { newValue in
      Swift.print("Submit with new value -> \(newValue)")
   }
}
```

## History

* `2.0.0`: Dropped 10.11/10.12 support. Added 'submit' support
* `1.1.0`: Support for SwiftUI (macOS only)
* `1.0.1`: Brought menu labels in line with Finder.
* `1.0.0`: Initial release

## License

MIT. Use it for anything you want, just attribute my work. Let me know if you do use it somewhere, I'd love to hear about it!

```
MIT License

Copyright (c) 2021 Darren Ford

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
