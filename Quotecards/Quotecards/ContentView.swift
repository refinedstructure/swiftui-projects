//
//  ContentView.swift
//  Quotecards
//
//  Created by Abhishek R on 02/07/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query var categories: [Category]
    @State private var showingAddCategory = false
    
    var body: some View {
        
        
        List(categories){ category in
            HStack{
                Image(systemName:category.icon)
                Text(category.descriptionText)
                Spacer()
            }
        }
        .toolbar
        {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    showingAddCategory.toggle()
                }) {
                    Label("Add Category", systemImage: "plus")
                }
                
                .sheet(isPresented: $showingAddCategory){
                    addCategoryView()
                }
            }
            
            
        }
        
    }
    
//    func addCategories()
//    {
//        do{
//            try modelContext.delete(model: Category.self)
//            }
//            catch{
//                print("Failed deletion")
//            }
//            
//        let category1 = Category(name: "Movies", descriptionText: "Quotes from your favorite movies", icon: "popcorn", baseColor: "yellow")
//        let category2 = Category(name: "Books", descriptionText: "Quotes from your favorite books", icon: "book", baseColor: "blue")
//        let category3 = Category(name: "Music", descriptionText: "Quotes from your favorite music", icon: "music.note", baseColor: "red")
//        let category4 = Category(name: "Sports", descriptionText: "Quotes from your favorite sports", icon: "football", baseColor: "green")
//        modelContext.insert(category1)
//        modelContext.insert(category2)
//        modelContext.insert(category3)
//        modelContext.insert(category4)
//    }
    
}
#Preview {
    ContentView()
}
