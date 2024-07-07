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
        GridItem(.adaptive(minimum: 200))
    ]
    
    var body: some View {
        NavigationStack {
        ScrollView{
                LazyVGrid(columns: categoryColumns, spacing:20) {
                    ForEach(categories, id: \.id) { category in
                        NavigationLink{ QuoteView(selectedCategory: category.name)
                        }label:
                        {
                            VStack{
                                Text(category.name).font(.title.bold()).padding()
                                Image(systemName:"\(category.icon)").resizable().scaledToFit().containerRelativeFrame(.horizontal) {size, axis in
                                    size * 0.2
                                }
                                Text(category.description).font(.caption).padding(.vertical)
                            }

                            .frame(width: 230, height: 190)
                            .foregroundStyle(.black)
                            .overlay(
                                Rectangle().stroke(.black).opacity(0.9)).frame(width:230, height:190).cornerRadius(2)
                        }
                    }
                }
                .padding(.vertical)
                .frame(maxWidth: .infinity)
                .background(.white)
                
            }
            .navigationTitle("Quote Cards")
            .background(.white)
        }
       
    }
}

#Preview {
    ContentView()
}
