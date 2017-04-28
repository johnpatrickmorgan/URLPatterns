//
//  StringMatching.swift
//  Pods
//
//  Created by John Morgan on 20/05/2016.
//
//

import Foundation

public func ~=(regex: Regex, string: String) -> Bool {
    
    return regex.matches(string, options: [.anchored])
}

public struct Regex: PatternMatching {
    
    public typealias MatchValue = String
    
    public private(set) var regex: NSRegularExpression?
    
    public init(regExp: NSRegularExpression) {
        
        self.regex = regExp
    }
    
    public init(_ pattern: String, _ options: NSRegularExpression.Options = [.caseInsensitive]) {
        
        do {
            self.regex = try NSRegularExpression(pattern: pattern, options: options)
        } catch {
            assertionFailure("Invalid Regex: \(error)")
        }
    }
    
    func matches(_ string: String, options: NSRegularExpression.MatchingOptions = []) -> Bool {
    
        return regex?.matchesWhole(string, options: options) ?? false
    }
}

extension NSRegularExpression {
    
    func matchesWhole(_ string: String, options: NSRegularExpression.MatchingOptions = []) -> Bool {
        
        let length = (string as NSString).length
        var hit = false
        enumerateMatches(in: string, options: options, range: NSMakeRange(0, length)) { result, flags, stop in
            guard let match = result else { return }
            if match.range.location == 0 && match.range.length == length {
                hit = true
                stop.pointee = true
            }
        }
        return hit
    }
}
