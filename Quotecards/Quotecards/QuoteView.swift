//
//  QuoteView.swift
//  Quotecards
//
//  Created by Abhishek R on 03/07/24.
//

import SwiftUI

//    let quotes: Quote

struct QuoteView: View {
    let selectedCategory: String
    var viewQuotes: [Quote] = []
  @State private var allQuotes: [Quote] = []
    

    
    let rows = [
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack{
            Text("\(selectedCategory.uppercased()) QUOTES").font(.title2)
        }
        
        ScrollView(.horizontal){
            LazyHGrid(rows:rows, spacing:5) {
                
                ForEach(allQuotes, id: \.id) { quote in
                        VStack{
                            Text(quote.quote).font(.title).padding()
                            Text("-- " + quote.author).font(.subheadline)
                        }
                        .frame(width:360, height:380)
                        .overlay(RoundedRectangle(cornerRadius: 20).background(.linearGradient(colors:[.purple,.white], startPoint: .top, endPoint: .bottom)).opacity(0.1)).padding(.horizontal)
                }}
        }.onAppear{
  
            allQuotes = decodeData(selectedCategory: selectedCategory)
            
        }
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
    
}

#Preview {
    QuoteView(
        selectedCategory: "tv"
    )
}
