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
    
    func application(application: UIApplication, didFinishLaunchingWithOptions options: [NSObject: AnyObject]?) -> Bool {
        
        if let url = options?[UIApplicationLaunchOptionsURLKey] as? NSURL, link = DeepLink(url: url) {
            DeepLinker.open(link)
        }
        
        let testURL = NSURL(string: "myscheme://myhost/users/john_morgan12/profile")!
        
        if let link = DeepLink(url: testURL) {
            DeepLinker.open(link)
        }
        
        return true
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        
        if let link = DeepLink(url: url) {
            return DeepLinker.open(link)
        }
        return false
    }
}

