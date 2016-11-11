//
//  DeepLinker.swift
//  URLPatterns
//
//  Created by John Morgan on 29/04/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation

struct DeepLinker {
    
    @discardableResult static func open(_ link: DeepLink, animated: Bool = true) -> Bool {
        
        switch link {
            
        case .profile(let userId):
            print("Opening profile for \(userId)")
        case .history:
            print("Opening history")
        case .chat(let room):
            print("Opening chat room \(room)")
        case .home:
            print("Opening home")
        case .settings:
            print("Opening settings")
        case .news:
            print("Opening news")
        case .terms:
            print("Opening terms")
        case .contact:
            print("Opening contact")
        }
        return true
    }
}
