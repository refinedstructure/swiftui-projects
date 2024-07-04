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
    
    let rows = [
        GridItem(.flexible())
    ]

    var body: some View {
        ScrollView(.horizontal){
            LazyHGrid(rows:rows, spacing:5) {
                ForEach(allQuotes, id: \.id) { quote in
                    VStack{
                        Text(quote.quote).font(.title).padding()
                        Text("-- " + quote.author)
                    }.frame(width:300, height:300)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke()).frame(width:500, height:500).foregroundStyle(.blue)
                    
                    
                }}
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
