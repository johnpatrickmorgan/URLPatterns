//
//  DeepLinker.swift
//  URLPatterns
//
//  Created by John Morgan on 29/04/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation

struct DeepLinker {
    
    static func open(link: DeepLink, animated: Bool = true) -> Bool {
        
        switch link {
            
        case .Profile(let userId):
            print("Opening profile for \(userId)")
        case .History:
            print("Opening history")
        case .Chat(let room):
            print("Opening chat room \(room)")
        case .Home:
            print("Opening home")
        case .Settings:
            print("Opening settings")
        case .News:
            print("Opening news")
        case .Terms:
            print("Opening terms")
        }
        return true
    }
}
