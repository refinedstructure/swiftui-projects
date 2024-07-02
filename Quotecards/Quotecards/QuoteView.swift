//
//  QuoteView.swift
//  Quotecards
//
//  Created by Abhishek Rane on 03/07/24.
//

import SwiftUI

let decoder = JSONDecoder()
let file = "quotes.json"

struct QuoteView: View {
    let quotes: Quote
    let selectedCategory: String
    
    var body: some View {
        Text(selectedCategory)
        
    }
}

#Preview {
    
    let quotes: Quote = Bundle.main.decode("quotes.json")
    
    return QuoteView(quotes: quotes[0]!)
    
    QuoteView(selectedCategory: "Test")
}
