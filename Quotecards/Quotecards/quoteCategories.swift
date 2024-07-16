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
