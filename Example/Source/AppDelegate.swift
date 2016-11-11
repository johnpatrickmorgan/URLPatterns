//
//  AppDelegate.swift
//  URLPatterns
//
//  Created by johnmorgan on 04/29/2016.
//  Copyright (c) 2016 johnmorgan. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions options: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        if let url = options?[UIApplicationLaunchOptionsKey.url] as? URL, let link = DeepLink(url: url) {
            DeepLinker.open(link)
        }
        
        let testURL = URL(string: "myscheme://myhost/users/john_morgan12/profile")!
        
        if let link = DeepLink(url: testURL) {
            DeepLinker.open(link)
        }
        
        return true
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        
        if let link = DeepLink(url: url) {
            return DeepLinker.open(link)
        }
        return false
    }
}

