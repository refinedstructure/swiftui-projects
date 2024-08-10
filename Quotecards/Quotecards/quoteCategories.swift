//
//  quoteCategories.swift
//  Quotecards
//
//  Created by Abhishek R on 02/07/24.
//

import Foundation


struct quoteCategories: Identifiable, Hashable {
    
    let id = UUID()
    let name: String
    let description: String
    let icon: String
    
}

@Observable
class QuoteCategoryData {
    let categories: [quoteCategories] = [
        quoteCategories(name: "TV", description: "Quotes from your favorite TV shows", icon: "tv"),
                    quoteCategories(name: "Movies", description: "Quotes from your favorite movies", icon: "popcorn"),
                    quoteCategories(name: "Books", description: "Quotes from your favorite books", icon: "books.vertical"),
                    quoteCategories(name: "Personalities", description: "Quotes from famous people", icon: "person.3")
                ]
    
//    Create an array of category names
    var categoryNames: [String] {
        categories.map { $0.name }
     }
     
//    Random element from the category names
     func randomCategory() -> String {
         categoryNames.randomElement() ?? "TV"
     }
    
    
}
