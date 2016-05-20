//
//  StringMatching.swift
//  Pods
//
//  Created by John Morgan on 20/05/2016.
//
//

import Foundation

public func ~=(pattern: String -> Bool, value: String) -> Bool {
    
    return pattern(value)
}

public func ~=(pattern: (String -> Bool)?, value: String) -> Bool {
    
    return pattern?(value) ?? false
}

public func regex(regExp: NSRegularExpression) -> (String) -> Bool {
    
    return { regExp.matches($0, options: [.Anchored]) }
}

public func regex(pattern: String, _ options: NSRegularExpressionOptions = [.CaseInsensitive]) throws -> (String) -> Bool {
    
    let regExp = try NSRegularExpression(pattern: pattern, options: options)
    
    return regex(regExp)
}

extension NSRegularExpression {
    
    func matches(string: String, options: NSMatchingOptions = []) -> Bool {
        
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
