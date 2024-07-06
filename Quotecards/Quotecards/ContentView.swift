//
//  ContentView.swift
//  Quotecards
//
//  Created by Abhishek R on 02/07/24.
//

import SwiftUI



struct ContentView: View {
    var tv_Shows: quoteCategories
        var movies: quoteCategories
        var books: quoteCategories
        var personalities: quoteCategories
        var categories: [quoteCategories]
    
    init(){
        self.tv_Shows = quoteCategories(name:"TV", description: "Quotes from your favorite TV shows", icon: "tv")
        self.movies = quoteCategories(name: "Movies", description: "Quotes from your favorite movies", icon: "popcorn")
        self.books = quoteCategories(name: "Books", description: "Quotes from your favorite books",icon: "book")
        self.personalities = quoteCategories(name:"Personalities", description: "Quotes from famous people", icon: "person")
        self.categories = [tv_Shows, movies, personalities, books ]
    }

    
    let categoryColumns = [
        GridItem(.flexible())
        
    ]
    
    var body: some View {
        
        
        NavigationStack {
            ScrollView{
                LazyVGrid(columns: categoryColumns, spacing: 15) {
                    ForEach(categories, id: \.id) { category in
                        NavigationLink{ QuoteView(selectedCategory: category.name)
                        }label:
                        {
                            VStack{
                                Text(category.name).font(.title).padding()
                                Image(systemName:"\(category.icon)").resizable().frame(width:80, height:80).scaledToFit().padding()
                                Text(category.description).font(.caption).padding()
                                    .foregroundStyle(.black.opacity(0.7))
                            }
                            .frame(width: 250, height: 250)
                            .clipShape(.rect(cornerRadius: 20))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10).stroke()).frame(width:250, height:250)
                                .foregroundStyle(.black)
                        }
                    }
                }
                .padding(.vertical)
                .frame(maxWidth: .infinity)
                .background(.ultraThickMaterial)
                
            }
            .navigationTitle("Quotes")
            .background(.ultraThinMaterial)

            
        }
       
    }
}

#Preview {
    ContentView()
}
