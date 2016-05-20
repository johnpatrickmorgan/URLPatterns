//
//  StringMatching.swift
//  Pods
//
//  Created by John Morgan on 20/05/2016.
//
//

import Foundation

public func ~=(regex: Regex, string: String) -> Bool {
    
    return regex.matches(string, options: [.Anchored])
}

public struct Regex: PatternMatching {
    
    public typealias MatchValue = String
    
    public private(set) var regex: NSRegularExpression?
    
    public init(regExp: NSRegularExpression) {
        
        self.regex = regExp
    }
    
    public init(_ pattern: String, _ options: NSRegularExpressionOptions = [.CaseInsensitive]) {
        
        do {
            self.regex = try NSRegularExpression(pattern: pattern, options: options)
        } catch {
            assertionFailure("Invalid Regex: \(error)")
        }
    }
    
    func matches(string: String, options: NSMatchingOptions = []) -> Bool {
    
        return regex?.matchesWhole(string, options: options) ?? false
    }
}

extension NSRegularExpression {
    
    func matchesWhole(string: String, options: NSMatchingOptions = []) -> Bool {
        
        let length = (string as NSString).length
        var hit = false
        enumerateMatchesInString(string, options: options, range: NSMakeRange(0, length)) { result, flags, stop in
            guard let match = result else { return }
            if match.range.location == 0 && match.range.length == length {
                hit = true
                stop.memory = true
            }
        }
        return hit
    }
}
