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

    @Query var categories: [Category]
    
    var body: some View {
        NavigationView {
            List(categories) { category in
                HStack {
                    Image(systemName: category.icon)
                    Text(category.name)
                    Text(category.descriptionText)
                    
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
}
