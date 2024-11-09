//
//  Categories.swift
//  Quotecards
//
//  Created by Abhishek Rane on 03/11/24.
//

import Foundation
import SwiftData

@Model
class Category {
    var name: String
    var descriptionText: String
    var icon: String = "quote.bubble"
    var baseColor: String = "blue"
    
    init(name: String, descriptionText: String, icon: String, baseColor: String) {
        self.name = name
        self.descriptionText = descriptionText
        self.icon = icon
        self.baseColor = baseColor
    }
}
