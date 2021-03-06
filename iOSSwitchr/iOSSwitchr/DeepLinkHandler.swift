//
//  DeepLinkHandler.swift
//  iOSSwitchr
//
//  Created by Alex Bartis on 13/05/2020.
//  Copyright © 2020 Alex Bartis. All rights reserved.
//

import Foundation
import UIKit

class DeepLinkHandler {
    static func handle(urlString: String, for browserType: Browser.ID) {
        
        var newURL: URL!
        
        switch browserType {
        case .Firefox:
            if let unwrappedURL = getFirefoxURL(from: urlString) {
                newURL = unwrappedURL
            }
            
        case .Chrome:
            if let unwrappedURL = getChromeURL(from: urlString) {
                newURL = unwrappedURL
            }
            
        default:
            return
        }
       
        UIApplication.shared.open(newURL)
    }
    
    private static func getFirefoxURL(from oldURLString: String) -> URL? {
        let newString =  "firefox://open-url?url=" + oldURLString
        guard let url = URL(string: newString) else {
            return nil
        }
        
        return url
    }
    
    private static func getChromeURL(from oldURLString: String) -> URL? {
        let existingScheme = oldURLString.components(separatedBy: ":").first ?? "https"
        let chromeScheme = existingScheme == "http" ? "googlechrome" : "googlechromes"
        let newURLString = oldURLString.replacingOccurrences(of: existingScheme, with: chromeScheme)
        
        guard let url = URL(string: newURLString) else {
            return nil
        }
        
        return url
    }
}
