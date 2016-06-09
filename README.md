# 🎯 URLPatterns 🎯

[![Version](https://img.shields.io/cocoapods/v/URLPatterns.svg?style=flat)](http://cocoapods.org/pods/URLPatterns)
[![License](https://img.shields.io/cocoapods/l/URLPatterns.svg?style=flat)](http://cocoapods.org/pods/URLPatterns)
![Swift](https://img.shields.io/badge/Swift-2.2-orange.svg)

URLPatterns is a small library to enable more idiomatic Swift pattern matching of URL path elements. 

`NSURL` is extended with the method `countedPathElements()`, which converts the URL's' array of path elements into a `Counted` enum. Each case in `Counted` has a different number of associated values, which makes pattern-matching each element easy:

```swift
if case .N4("user", let userId, "profile", _) = url.countedPathElements() {
    // show profile for userId
}
```

 `Counted` enables us to pattern match paths with any number of elements, and supports **expression**, **wildcard** and **value-binding** patterns for its associated values. It can match based on `Begins` and `Ends`, which match based on the first/ last elements only, and can even match a particular path element based on a regular expression. Here's an example of a `DeepLink` enum which has a failable initializer that takes an `NSURL`:


```swift
enum DeepLink {

    case Home, History, Settings, Terms, News, Contact
    case Chat(room: String)
    case Profile(userId: String)
}

extension DeepLink {

    init?(url: NSURL) {

        guard url.scheme == "myscheme" else { return nil }
        guard url.host == "myhost" else { return nil }

        switch url.countedPathComponents() {

        case .N0, .N1(""):                          self = .Home
        case .N1("history"):                        self = .History
        case .N2(_, "settings"):                    self = .Settings
        case .N2("chat", let room):                 self = .Chat(room: room)
        case .N3("users", let userId, "profile"):   self = .Profile(userId: userId)
        case .N1(Regex(contact.*))                  self = .Contact
        case Begins("news", "latest"):              self = .News
        case Ends("terms"):                         self = .Terms		
        default:                                    return nil
        }
    }
}
```

## Installation

URLPatterns is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "URLPatterns"
```

## License

URLPatterns is available under the MIT license. See the LICENSE file for more info.
