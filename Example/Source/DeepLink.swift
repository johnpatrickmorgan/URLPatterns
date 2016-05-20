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
    
    case Home, History, Settings, Terms, News, Contact
    case Chat(room: String)
    case Profile(userId: String)
}

extension DeepLink {
    
    init?(url: NSURL) {
        
        guard url.scheme == "myscheme" else { return nil }
        guard url.host == "myhost" else { return nil }
        
        switch url.countedPathComponents() {

        case .N0, .N1(""):                          self = .Home
        case .N1("history"):                        self = .History
        case .N2(_, "settings"):                    self = .Settings
        case .N2("chat", let room):                 self = .Chat(room: room)
        case .N3("users", let userId, "profile"):   self = .Profile(userId: userId)
        case begins("news", "latest"):              self = .News
        case ends("terms"):                         self = .Terms
        case .N1(try? regex("contact-us.*")):
                                                    self = .Contact
            
        default:                                    return nil
        }
    }
}
