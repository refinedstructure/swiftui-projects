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
        self.books = quoteCategories(name: "Books", description: "Quotes from your favorite books",icon: "books.vertical")
        self.personalities = quoteCategories(name:"Personalities", description: "Quotes from famous people", icon: "person.3")
        self.categories = [tv_Shows, movies, personalities, books]
//        self.categoryNames = [tv_Shows.name, movies.name, books.name, personalities.name]
    }
    
    
    let categoryColumns = [
        GridItem(.adaptive(minimum: 200))
    ]
    
    
    var body: some View {
        NavigationStack{
            ScrollView{
                LazyVGrid(columns: categoryColumns, spacing:20) {
                    ForEach(categories, id: \.id) { category in
                        NavigationLink(value: category.name, label: {
                            VStack{
                                Text(category.name).font(.title.bold()).padding()
                                Image(systemName:"\(category.icon)").resizable().scaledToFit().containerRelativeFrame(.horizontal) {size, axis in
                                    size * 0.2
                                }
                                Text(category.description).font(.caption).padding(.vertical).foregroundColor(.black)
                            }
                            .frame(width: 230, height: 190)
                            .foregroundStyle(.black)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20).frame(width: 290, height: 190, alignment: .center).foregroundStyle(.gray.opacity(0.3)).shadow(radius: 5)
                                //                                Rectangle().stroke(.gray).opacity(0.9)).frame(width:230, height:190)
                                       
                            )
                        }
                        )
                    }
                    .navigationDestination(for: String.self) { categoryStringValue in
                    QuoteView(selectedCategory: categoryStringValue)
                    }
                    }
                .navigationTitle("Quote Cards")
                .background(.white)
            }
        }
    }
}

#Preview {
    ContentView()
}
