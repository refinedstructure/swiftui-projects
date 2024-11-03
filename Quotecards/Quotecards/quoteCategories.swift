//
//  quoteCategories.swift
//  Quotecards
//
//  Created by Abhishek R on 02/07/24.
//

import Foundation


//TODO - Category data should be queried from the main db instead of a separate data model
//
//struct quoteCategories: Identifiable, Hashable {
//    
//    let id = UUID()
//    let name: String
//    let description: String
//    let icon: String
//    let baseColor: String
//    
//}

//@Observable
//class QuoteCategoryData {
//    let categories: [quoteCategories] = [
//        quoteCategories(name: "TV", description: "Quotes from your favorite TV shows", icon: "tv", baseColor: "blue"),
//                    quoteCategories(name: "Movies", description: "Quotes from your favorite movies", icon: "popcorn", baseColor: "yellow"),
//                    quoteCategories(name: "Books", description: "Quotes from your favorite books", icon: "books.vertical", baseColor: "red"),
//                    quoteCategories(name: "Personalities", description: "Quotes from famous people", icon: "person.3", baseColor: "green")
//                ]
//    
//    Create an array of category names
//    var categoryNames: [String] {
//        categories.map { $0.name }
//     }
//    //Create an array of base colors
//    
//    var categoryColors: [String: String] {
//        Dictionary(uniqueKeysWithValues: categories.map { ($0.name, $0.baseColor) })
//    }
//     
////    Random element from the category names
//     func randomCategory() -> String {
//         categoryNames.randomElement() ?? "TV"
//     }
//    
//    // Find base color
//    
//    func fetchCategoryColor(inputCategory:String) -> String {
//        return categoryColors[inputCategory] ?? "nil"
//    }
//    
//}
