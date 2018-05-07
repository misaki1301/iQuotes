//
//  Quote.swift
//  iQuotes
//
//  Created by Alumnos on 5/5/18.
//  Copyright © 2018 Alumnos. All rights reserved.
//

import Foundation
import SwiftyJSON

class Quote {
    var quote: String
    var author: String?
    var length: String
//    var tags: [Tag]
    var category: String
    var title: String
    var date: String?
    var id: String?
    
    init() {
        quote = ""
        author = ""
        length = ""
//        tags = []
        category = ""
        title = ""
        date = ""
        id = ""
    }
    
    init(quote: String, author: String, length: String, category: String, title: String, date: String, id: String) {
        self.quote = quote
        self.author = author
        self.length = length
        self.category = category
        self.title = title
        self.date = date
        self.id = id
    }
    
    init(from JSONObject: JSON) {
        quote = JSONObject["quote"].stringValue
        author = JSONObject["author"].stringValue
        length = JSONObject["length"].stringValue
//        tags = Tag.from(tagsArray: JSONObject[""].arrayObject)
        category = JSONObject["category"].stringValue
        title = JSONObject["title"].stringValue
        date = JSONObject["date"].stringValue
        id = JSONObject["id"].stringValue
    }
    
    public static func from(jsonQuotes: [JSON]) -> [Quote] {
        var quotes: [Quote] = []
        let count = jsonQuotes.count
        for i in 0...count - 1 {
            quotes.append(Quote.init(from: jsonQuotes[i]))
        }
        return quotes
    }
    
}
