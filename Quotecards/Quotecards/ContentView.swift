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
        self.personalities = quoteCategories(name:"Personalities", description: "Quotes from famous people", icon: "person")
        self.categories = [tv_Shows, movies, books, personalities]
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
                            Text(category.name).font(.title)
                            Image(systemName:"\(category.icon)").resizable().frame(width:100, height:100).scaledToFit().padding()
                            Text(category.description).font(.caption).padding()
                                .foregroundStyle(.black.opacity(0.7))
                        }
                        .clipShape(.rect(cornerRadius: 20))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10).stroke())
                         
                    }
               
                }
                .padding(.vertical)
                .frame(maxWidth:.infinity)
                .background(.ultraThinMaterial)
                
            }
            .navigationTitle("Quotes")
            .background(.ultraThinMaterial)

            
        }
       
    }
}

#Preview {
    ContentView()
}
