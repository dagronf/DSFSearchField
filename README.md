# DSFSearchField

![](https://img.shields.io/github/v/tag/dagronf/DSFSearchField) ![](https://img.shields.io/badge/macOS-10.11+-red) ![](https://img.shields.io/badge/Swift-5.0-orange.svg)
![](https://img.shields.io/badge/License-MIT-lightgrey) [![](https://img.shields.io/badge/spm-compatible-brightgreen.svg?style=flat)](https://swift.org/package-manager)

A simple NSSearchField with a localizable, managed recent searches menu.

## Why

`NSSearchField` has a wonderful built-in mechanism for handling recents list which requires the developer to provide a menu to provide the recents list.  This class automatically provides a suitable localizable menu structure.

`DSFSearchField` inherits from `NSSearchField` so search delegates, actions etc. all work as expected.

## Installation

### Swift Package Manager

Add `https://github.com/dagronf/DSFSearchField` to your project.

### Direct

Copy `DSFSearchField.swift` to your project.

## Usage

### Via Interface Builder

* Add a new `NSSearchField` using Interface Builder, then change the class type to `DSFSearchField`.
* If you want to save the recent searches list, set `Autosave` in the Attributes Inspector of Interface Builder to a unique string for your project.

### Programatically

```swift
let searchField = DSFSearchField(frame: rect, recentsAutosaveName: "primary-search")
```

## Conveniences

### Block-based callback for search text changes

In addition to the standard `NSSearchField` action callback, `DSFSearchField` provides a simple block-based callback mechanism (optional) to detect changes to the search string.

```swift
   searchField.searchTermChangeCallback = { [weak self] newSearchTerm in
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
   s.addObserver(
      self, 
      forKeyPath: #keyPath(DSFSearchField.searchTerm), 
      options: [.new], 
      context: nil)
```


## History

* `1.0.0`: Initial release


## License

```
MIT License

Copyright (c) 2020 Darren Ford

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
