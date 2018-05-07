//
//  Tag.swift
//  iQuotes
//
//  Created by Alumnos on 5/5/18.
//  Copyright © 2018 Alumnos. All rights reserved.
//

import Foundation
import SwiftyJSON

class Tag {
    var name: String
    
    init() {
        name = ""
    }
    
    init(name: String) {
        self.name = name
    }
    static func from(tagsArray: [String]) -> [Tag] {
        var tags: [Tag] = []
        let count = tagsArray.count
        for i in 0...count - 1 {
            tags.append(Tag.init(name: tagsArray[i]))
        }
        return tags
    }
}
