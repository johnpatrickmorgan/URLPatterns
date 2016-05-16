//
//  FoundationExtensions.swift
//  Pods
//
//  Created by John Morgan on 29/04/2016.
//
//

import Foundation

extension NSURLComponents {
    
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

extension NSURL {
    
    public func countedPathComponents(excludingLeadingBackslash: Bool = true) -> Counted<String> {
        
        var components = pathComponents ?? []
        if let first = components.first where excludingLeadingBackslash && first == "/" {
            components.removeFirst()
        }
        return Counted(components)
    }
}

extension NSURL {
    
    public func queryArguments() -> [String : String?] {
        
        guard let components = NSURLComponents(URL: self, resolvingAgainstBaseURL: true) else { return [:] }
        
        return components.queryArguments()
    }
    
    public func flatQueryArguments() -> [String : String] {
        
        guard let components = NSURLComponents(URL: self, resolvingAgainstBaseURL: true) else { return [:] }
        
        return components.flatQueryArguments()
    }
}
