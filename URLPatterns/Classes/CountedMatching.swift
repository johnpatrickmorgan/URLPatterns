//
//  CountedMatching.swift
//  Pods
//
//  Created by John Morgan on 14/05/2016.
//
//

import Foundation

public protocol CountedMatching {
    
    associatedtype Value
    
    func matches(value: Counted<Value>) -> Bool
}

public func ~=<E: CountedMatching where E.Value: PatternMatching>(pattern: E, value: Counted<E.Value>) -> Bool {
    
    return pattern.matches(value)
}

public struct Begins<Element: PatternMatching>: CountedMatching {
    
    var patternElements: [Element]
    
    public init(_ elements: Element...) {

        self.patternElements = elements
    }
    
    public func matches(value: Counted<Element.MatchValue>) -> Bool {
        
        return patternElements ~= Array(value.elements.prefix(patternElements.count))
    }
}

public struct Ends<Element: PatternMatching>: CountedMatching {
    
    var patternElements: [Element]
    
    public init(_ elements: Element...) {
        
        self.patternElements = elements
    }
    
    public func matches(value: Counted<Element.MatchValue>) -> Bool {
        
        return patternElements ~= Array(value.elements.suffix(patternElements.count))
    }
}
