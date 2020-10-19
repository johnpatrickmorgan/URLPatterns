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
    
    func matches(_ value: Counted<Value>) -> Bool
}

public func ~=<E: CountedMatching>(pattern: E, value: Counted<E.Value>) -> Bool where E.Value: PatternMatching {
    
    return pattern.matches(value)
}

public struct Begins<Element: PatternMatching>: CountedMatching {
    
    var patternElements: [Element]
    
    public init(_ elements: Element...) {

        self.patternElements = elements
    }
    
    public func matches(_ value: Counted<Element.MatchValue>) -> Bool {
        
        return patternElements ~= Array(value.elements.prefix(patternElements.count))
    }
}

public struct Ends<Element: PatternMatching>: CountedMatching {
    
    var patternElements: [Element]
    
    public init(_ elements: Element...) {
        
        self.patternElements = elements
    }
    
    public func matches(_ value: Counted<Element.MatchValue>) -> Bool {
        
        return patternElements ~= Array(value.elements.suffix(patternElements.count))
    }
}
