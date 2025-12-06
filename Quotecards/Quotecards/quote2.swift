//
//  quote2.swift
//  Quotecards
//
//  Created by Abhishek Rane on 15/10/24.
//

import SwiftData
import Foundation

@Model
class QuoteCard {
    var id: UUID
    var quoteText: String
    var quoteCategory: Collection
    var quoteAuthor: String
    var quoteBookmarkStatus: Bool
    var quoteHidden: Bool
    
    init(id: UUID = UUID(), quoteText: String, quoteCategory: Collection = defaultCategory, quoteAuthor: String, quoteBookmarkStatus: Bool = false, quoteHidden: Bool = false) {
        self.id = id
        self.quoteText = quoteText
        self.quoteCategory = quoteCategory
        self.quoteAuthor = quoteAuthor
        self.quoteBookmarkStatus = quoteBookmarkStatus
        self.quoteHidden = quoteHidden
    }
}
