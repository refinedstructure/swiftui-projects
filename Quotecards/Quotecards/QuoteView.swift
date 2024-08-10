//
//  QuoteView.swift
//  Quotecards
//
//  Created by Abhishek R on 03/07/24.
//

import SwiftUI


struct QuoteView: View {
    let selectedCategory: String
    @Binding var path: NavigationPath
    
//    @State private var categories = QuoteCategoryData()
    
    var viewQuotes: [Quote] = []
    @State private var allQuotes: [Quote] = []

    
    let rows = [
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack{
                Text("\(selectedCategory.uppercased()) QUOTES").font(.title2).foregroundStyle(.gray).shadow(radius: 10)
        }
        ScrollView(.horizontal){
            LazyHGrid(rows:rows, spacing:10) {
                ForEach(allQuotes, id: \.id) { quote in
                    VStack{
                            Text(quote.quote).font(.title)
                            Text("-- " + quote.author).font(.subheadline)
                    }
                    .frame(width:360, height:400)
                    .overlay(RoundedRectangle(cornerRadius: 20).background(.linearGradient(colors:[.red,.white], startPoint: .topLeading, endPoint: .bottomTrailing)).opacity(0.14)).padding(.horizontal).shadow(radius: 10)
                }
            }
            Spacer()
            
        }.onAppear{
            allQuotes = decodeData(selectedCategory: selectedCategory)
        }
    }
}

#Preview {
    QuoteView(
        selectedCategory: "tv",
        path: .constant(NavigationPath())
    )
}
