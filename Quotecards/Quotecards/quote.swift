//
//  quote.swift
//  Quotecards
//
//  Created by Abhishek Rane on 03/07/24.
//

import Foundation

struct Quote: Codable, Identifiable{
    let id: Int
    let quoteCategory : String
    let quote: String
    let author: String
}

