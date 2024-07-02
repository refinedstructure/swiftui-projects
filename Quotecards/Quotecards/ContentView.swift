//
//  ContentView.swift
//  Quotecards
//
//  Created by Abhishek Rane on 02/07/24.
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
        self.personalities = quoteCategories(name:"Personalities", description: "Quotes from famous people", icon: "person.2.wave.2.fill")
        self.categories = [tv_Shows, movies, personalities, books ]
    }

    
    let categoryColumns = [
        GridItem(.flexible())
        
    ]
    
    var body: some View {
        
        
        NavigationStack {
            ScrollView{
                LazyVGrid(columns: categoryColumns, spacing: 20) {
                    ForEach(categories, id: \.id) { category in
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
                    }
               
                }
                .padding(.vertical)
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
