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
    @Query(sort: \Collection.name) private var collection: [Collection]
    @State private var navigationPath = NavigationPath()
    
    var body: some View {

        NavigationView {
            VStack{
                List(collection) { collection in
                    HStack {
                        NavigationLink{
                            QuoteView(selectedCategory: collection.name, path: $navigationPath)
                        }
                        label:{
                            Image(systemName: collection.icon)
                            Text(collection.name)
                            
                        }
                    }
                }
                .navigationBarTitle("Quote Cards")
//                .toolbarVisibility(.hidden)
                .overlay{
                    if collection.isEmpty {
                        ContentUnavailableView{
                            Text("Add your first quote")
                                .font(.title)
                                .fontWeight(.bold)
                            Image("wallquote")
                                .resizable()
                                .frame(width: 250, height: 200)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                           
                        }
                        description:{
                            Text("Add your own quote or load hand-picked collections").font(.subheadline)
                        }
                        actions:{
                            Button("Explore Existing Collections"){
                                let newCategory = Collection(name: "Books", descriptionText: "Quotes from the best books", icon: "book.fill", baseColor: "red")
                                let newCategory2 = Collection(name: "Movies", descriptionText: "Quotes from the best movies", icon: "popcorn.fill", baseColor: "red")
                                
                                modelContext.insert(newCategory)
                                modelContext.insert(newCategory2)
                                
                            }
                            .buttonStyle(BorderedButtonStyle()).tint(.black)
                        }
                    }
                    
                }
            }
            .background(Color(UIColor.secondarySystemBackground))
            
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    
                    Button{
                        showingAddCategory.toggle()
                        
                    }label: {
                        Image(systemName: "plus.circle")
                            .foregroundStyle(.black)
                        Text("Collection")
                            .tint(.black)
                    }
                    
                    
                }
                ToolbarItem(placement: .navigationBarTrailing){
                    Button{
                        showingAddQuote.toggle()
                        
                    }

                label:
                    {
                        Image(systemName: "plus.circle.fill")
                            .foregroundStyle(.black)
                        Text("Quote")
                            .tint(.black)
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
        .modelContainer(for: Collection.self, inMemory: true)
}
