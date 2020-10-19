# 🎯 URLPatterns 🎯

[![Version](https://img.shields.io/cocoapods/v/URLPatterns.svg?style=flat)](http://cocoapods.org/pods/URLPatterns)
[![License](https://img.shields.io/cocoapods/l/URLPatterns.svg?style=flat)](http://cocoapods.org/pods/URLPatterns)
![Swift](https://img.shields.io/badge/Swift-5.3-orange.svg)

URLPatterns is a small library to enable more idiomatic Swift pattern matching of URL path elements. 

`URL` is extended with the method `countedPathElements()`, which converts the URL's' array of path elements into a `Counted` enum. Each case in `Counted` has a different number of associated values, which makes pattern-matching each element easy:

```swift
if case .n4("user", let userId, "profile", _) = url.countedPathElements() {
    // show profile for userId
}
```

`Counted` enables us to pattern match paths with any number of elements, and supports **expression**, **wildcard** and **value-binding** patterns for its associated values. It can match based on `Begins` and `Ends`, which match based on the first/ last elements only, and can even match a particular path element based on a regular expression. Here's an example of a `DeepLink` enum which has a failable initializer that takes a `URL`:


```swift
enum DeepLink {

    case home, history, settings, terms, news, contact
    case chat(room: String)
    case profile(userId: String)
}

extension DeepLink {

    init?(url: URL) {

        guard url.scheme == "myscheme" else { return nil }
        guard url.host == "myhost" else { return nil }

        switch url.countedPathComponents() {

        case .n0, .n1(""):                          self = .home
        case .n1("history"):                        self = .history
        case .n2(_, "settings"):                    self = .settings
        case .n2("chat", let room):                 self = .chat(room: room)
        case .n3("users", let userId, "profile"):   self = .profile(userId: userId)
        case .n1(Regex(contact.*))                  self = .contact
        case Begins("news", "latest"):              self = .news
        case Ends("terms"):                         self = .terms		
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
