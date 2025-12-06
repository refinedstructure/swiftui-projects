//
//  Categories.swift
//  Quotecards
//
//  Created by Abhishek Rane on 03/11/24.
//

import Foundation
import SwiftData

@Model
class Collection {
    var name: String
    var descriptionText: String
    var icon: String
    var baseColor: String
    
    init(name: String, descriptionText: String, icon: String = "quote.bubble", baseColor: String = "blue") {
        self.name = name
        self.descriptionText = descriptionText
        self.icon = icon
        self.baseColor = baseColor
    }
}

let defaultCategory = Collection(name: "My Quotes", descriptionText: "Default category for your own quotes", icon: "quote.bubble", baseColor: "blue")
