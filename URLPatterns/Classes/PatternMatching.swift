//
//  PatternMatching.swift
//  Pods
//
//  Created by John Morgan on 20/05/2016.
//
//

import Foundation

public protocol PatternMatching {
    
    associatedtype MatchValue
    
    func ~=(lhs: Self, rhs: MatchValue) -> Bool
}

public func ~=<E: PatternMatching>(patterns: [E], values: [E.MatchValue]) -> Bool {
    
    guard patterns.count == values.count else { return false }
    
    for (index, pattern) in patterns.enumerate() {
        if !(pattern ~= values[index]) { return false }
    }
    return true
}

extension String: PatternMatching {
    
    public typealias MatchValue = String
}
