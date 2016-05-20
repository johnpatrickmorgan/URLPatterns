//
//  CountedMatching.swift
//  Pods
//
//  Created by John Morgan on 14/05/2016.
//
//

import Foundation

public func ~=<E>(pattern: (Counted<E>) -> Bool, value: Counted<E>) -> Bool {

    return pattern(value)
}

public func ends<E: Equatable>(patternElements: E...) -> (Counted<E>) -> Bool {
    
    return { Array($0.elements.suffix(patternElements.count)) == patternElements }
}


public func begins<E: Equatable>(patternElements: E...) -> (Counted<E>) -> Bool {
    
    return { Array($0.elements.prefix(patternElements.count)) == patternElements }
}
