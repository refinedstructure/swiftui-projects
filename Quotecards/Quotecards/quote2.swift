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
    var quoteCategory: Category?
    var quoteAuthor: String
    var quoteBookmarkStatus: Bool
    
    init(quoteText: String, quoteCategory: Category? = nil, quoteAuthor: String, quoteBookmarkStatus: Bool) {
        self.id = UUID()
        self.quoteText = quoteText
        self.quoteCategory = quoteCategory
        self.quoteAuthor = quoteAuthor
        self.quoteBookmarkStatus = quoteBookmarkStatus
    }
}


