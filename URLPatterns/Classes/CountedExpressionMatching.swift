//
//  CountedExpressionMatching.swift
//  Pods
//
//  Created by John Morgan on 14/05/2016.
//
//

import Foundation

public struct Begins<E> {
    
    var elements: [E]
    
    public init(_ elements: E...) {
        
        self.elements = elements
    }
}

public func ~=<E: Equatable>(pattern: Begins<E>, value: Counted<E>) -> Bool {

    return Array(value.elements.prefix(pattern.elements.count)) == pattern.elements
}

public struct Ends<E> {
    
    var elements: [E]
    
    public init(_ elements: E...) {
        
        self.elements = elements
    }
}

public func ~=<E: Equatable>(pattern: Ends<E>, value: Counted<E>) -> Bool {
    
    return Array(value.elements.suffix(pattern.elements.count)) == pattern.elements
}
