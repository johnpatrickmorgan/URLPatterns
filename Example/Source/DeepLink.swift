//
//  DeepLink.swift
//  URLPatterns
//
//  Created by John Morgan on 29/04/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import URLPatterns

enum DeepLink {
    
    case home, history, settings, terms, news, contact
    case chat(room: String)
    case profile(userId: String)
}

extension DeepLink {
    
    init?(url: URL) {
        
        guard url.scheme == "myscheme" else { return nil }
        guard url.host == "myhost" else { return nil }
        
        switch url.countedPathComponents() {

        case .n0, .n1(""):                          self = .home
        case .n1("history"):                        self = .history
        case .n2(_, "settings"):                    self = .settings
        case .n2("chat", let room):                 self = .chat(room: room)
        case .n3("users", let userId, "profile"):   self = .profile(userId: userId)
        case Ends(Regex("contact-us.*")):           self = .contact
        case Ends("terms"):                         self = .terms
        case Begins("news", "latest"):              self = .news
            
        default:                                    return nil
        }
    }
}
