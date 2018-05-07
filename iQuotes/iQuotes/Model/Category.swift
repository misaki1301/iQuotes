//
//  Category.swift
//  iQuotes
//
//  Created by Alumnos on 5/5/18.
//  Copyright © 2018 Alumnos. All rights reserved.
//

import Foundation

class Category {
    var name: String
    
    init() {
        name = ""
    }
    
    init(name: String) {
        self.name = name
    }
    
    public static func from(dCategory: Dictionary<String, String>) -> [Category] {
        var categories: [Category] = []
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dCategory, options: .prettyPrinted)
            let decoded = try JSONSerialization.jsonObject(with: jsonData, options: [])
            if let dictFromJSON = decoded as? [String:String] {
                for (key, _) in dictFromJSON {
                    categories.append(Category.init(name: key))
//                    print(key)
                }
            }
        } catch {
            print(error.localizedDescription)
        }
        return categories
    }
    
    public static func getUrlToSomeImage(dURLs: Dictionary<String, String>) -> String {
        var urlToRegularImage: String = ""
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dURLs, options: .prettyPrinted)
            let decoded = try JSONSerialization.jsonObject(with: jsonData, options: [])
            if let dictFromJSON = decoded as? [String:String] {
                for (key, value) in dictFromJSON {
                    if (key == "regular") {
                        urlToRegularImage = value
                    }
//                    print(key)
                }
            }
        } catch {
            print(error.localizedDescription)
        }
        return urlToRegularImage
    }
}
