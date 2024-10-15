//
//  quote2.swift
//  Quotecards
//
//  Created by Abhishek Rane on 15/10/24.
//

import Foundation
import SwiftData

@Model
class quoteCard: Identifiable {
    var id: String
    var quoteText: String
    var quoteCategory: String
    var quoteAuthor: String
    
    init(){
        id = UUID().uuidString
        self.quoteText = ""
        self.quoteCategory = ""
        self.quoteAuthor = ""
    }
}


