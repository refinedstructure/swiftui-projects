//
//  quote.swift
//  Quotecards
//
//  Created by Abhishek R on 03/07/24.
//

import Foundation

struct Quote: Codable, Identifiable{
    let id: Int
    let quoteCategory : String
    let quote: String
    let author: String
}

func decodeData(selectedCategory:String) -> [Quote]
{
    guard let quotesJSONURL = Bundle.main.url(forResource: "quotes", withExtension: "json") else {
        fatalError("Could not load quotes.json")
    }
    
    guard let quotesData = try? Data(contentsOf: quotesJSONURL) else {
        fatalError("couldn't convert data")
    }
    
    let decoder = JSONDecoder()
    
    guard let decodedQuotes = try? decoder.decode([Quote].self, from: quotesData) else {
        fatalError("There was a problem decoding the data...")
    }
    
    let decodedQuotes2 = decodedQuotes.filter({$0.quoteCategory == selectedCategory.lowercased()})
    
    return decodedQuotes2
}
