//
//  QuoteView.swift
//  Quotecards
//
//  Created by Abhishek Rane on 03/07/24.
//

import SwiftUI








//    let quotes: Quote

struct QuoteView: View {
    let selectedCategory: String
    @State private var allQuotes: [Quote] = []
    

    var body: some View {
        ScrollView(.horizontal){
            ForEach(allQuotes, id: \.id) { quote in
                LazyHStack{
                    Text(quote.quote)
                }
            }
        }.onAppear{
            allQuotes = decodeData()

        }
    }
    
    func decodeData() -> [Quote]
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
        return decodedQuotes
    }
    
}

#Preview {
    QuoteView(
        selectedCategory: "Test"
        
    )
}
