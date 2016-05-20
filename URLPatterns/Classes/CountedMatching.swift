//
//  CountedMatching.swift
//  Pods
//
//  Created by John Morgan on 14/05/2016.
//
//

import Foundation


public protocol PatternMatching {
    
    associatedtype MatchValue
    
    func ~=(lhs: Self, rhs: MatchValue) -> Bool
}

extension String: PatternMatching {

    public typealias MatchValue = String
}

public func ~=<E>(pattern: (Counted<E>) -> Bool, value: Counted<E>) -> Bool {

    return pattern(value)
}

public func ~=<E: PatternMatching>(patterns: [E], values: [E.MatchValue]) -> Bool {
    
    guard patterns.count == values.count else { return false }
    
    for (index, pattern) in patterns.enumerate() {
        if !(pattern ~= values[index]) { return false }
    }
    return true
}

public func ends<E: PatternMatching where E.MatchValue == String>(patternElements: E...) -> (Counted<String>) -> Bool {
    
    return { patternElements ~= Array($0.elements.suffix(patternElements.count)) }
}


public func begins<E: PatternMatching>(patternElements: E...) -> (Counted<E.MatchValue>) -> Bool {
    
    return { patternElements ~= Array($0.elements.prefix(patternElements.count)) }
}
