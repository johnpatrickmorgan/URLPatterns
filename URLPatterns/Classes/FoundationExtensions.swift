//
//  FoundationExtensions.swift
//  Pods
//
//  Created by John Morgan on 29/04/2016.
//
//

import Foundation

extension URLComponents {
    
    public func queryArguments() -> [String : String?] {
        
        var arguments = [String : String?]()
        
        for item in queryItems ?? [] {
            arguments[item.name] = item.value
        }
        return arguments
    }
    
    public func flatQueryArguments() -> [String : String] {
        
        var arguments = [String : String]()
        
        for (key, value) in queryArguments() {
            if value != nil {
                arguments[key] = value
            }
        }
        return arguments
    }
}

extension URL {
    
    public func countedPathComponents(_ excludingLeadingBackslash: Bool = true) -> Counted<String> {
        
        if let first = pathComponents.first , excludingLeadingBackslash && first == "/" {
            return Counted(sequence: pathComponents.dropFirst())
        }
        return Counted(pathComponents)
    }
}

extension URL {
    
    public func queryArguments() -> [String : String?] {
        
        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: true) else { return [:] }
        
        return components.queryArguments()
    }
    
    public func flatQueryArguments() -> [String : String] {
        
        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: true) else { return [:] }
        
        return components.flatQueryArguments()
    }
}
