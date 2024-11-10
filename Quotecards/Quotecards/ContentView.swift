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
    @State private var showingAddCategory = false
    @State private var showingAddQuote = false
    @Query(sort: \Category.name) private var categories: [Category]
    @State private var navigationPath = NavigationPath()

    var body: some View {
        NavigationView {
            List(categories) { category in
                HStack {
                    NavigationLink{
                        QuoteView(selectedCategory: category.name, path: $navigationPath)
                    }
                    label:{
                        Image(systemName: category.icon)
                        Text(category.descriptionText)
                    }
                    
                }
            }
            .navigationTitle("Quote Cards")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    
                    Button{
                        showingAddCategory.toggle()
                        
                    }label: {
                        Image(systemName: "plus.circle")
                        Text("Category")
                    }
                    
                    
                }
                ToolbarItem(placement: .navigationBarTrailing){
                    Button{
                        showingAddQuote.toggle()
                    }
                label:
                    {
                        Image(systemName: "plus.circle.fill")
                        Text("Quote")
                    }
                    
                }
                
            }
        }
        .sheet(isPresented: $showingAddCategory, content: {
            NavigationStack {
                addCategoryView()
            }.presentationDetents([.medium])
        })
        .sheet(isPresented: $showingAddQuote, content: {
            NavigationStack{
                addNewQuoteView()
            }.presentationDetents([.medium])
        })
           
        }
    }


#Preview {
    ContentView()
        .modelContainer(for: Category.self, inMemory: true)
}
