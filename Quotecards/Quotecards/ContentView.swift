//
//  ContentView.swift
//  Quotecards
//
//  Created by Abhishek R on 02/07/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var path = NavigationPath()
    @State private var categories = QuoteCategoryData()
    
    let categoryColumns = [
        GridItem(
            .adaptive(
                minimum: 200
            )
        )
    ]
    var body: some View {
        
   
        NavigationStack(path: $path)
        {
      
            ScrollView{
                NavigationLink(destination: AddQuoteView()){
                    Image(systemName: "plus")
                    Text("Add New Quote")
                }.foregroundStyle(.black)
                    .padding()
                
                LazyVGrid(columns: categoryColumns,spacing:20) {
                    ForEach(
                        categories.categories,
                        id: \.id
                    ) { category in
                        NavigationLink(value: category.name,
                                       label: {
                            VStack{
                                Text(
                                    category.name
                                ).font(
                                    .title.bold()
                                ).padding()
                                Image(
                                    systemName:"\(category.icon)"
                                ).resizable().scaledToFit().containerRelativeFrame(
                                    .horizontal
                                ) {
                                    size,
                                    axis in
                                    size * 0.2
                                }
                                Text(
                                    category.description
                                ).font(
                                    .caption
                                ).padding(
                                    .vertical
                                ).foregroundColor(
                                    .black
                                )
                            }
                            
                            .frame(
                                width: 230,
                                height: 190
                            )
                            .foregroundStyle(
                                .black
                            )
                            .overlay(
                                RoundedRectangle(
                                    cornerRadius: 20
                                ).frame(
                                    width: 290,
                                    height: 190,
                                    alignment: .center
                                ).foregroundStyle(
                                    .gray.opacity(
                                        0.3
                                    )
                                ).shadow(
                                    radius: 5
                                )
                            )
                        }
                        )
                    }
                    Button("Random Category", systemImage: "shuffle"){
                        path.append(categories.randomCategory())
                    }
                    .padding()
                    .background(.gray.opacity(0.3))
                    .foregroundStyle(.black)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    
                }
                
                .navigationDestination(
                    for: String.self
                ) { categoryStringValue in
                    QuoteView(
                        selectedCategory: categoryStringValue, path: $path
                    )
                }
                .navigationTitle("Quotes").padding()
                .navigationBarTitleDisplayMode(.inline)
                .toolbarBackground(.white)
                //                .toolbar(.hidden, for: .navigationBar)
            }
        }
    }
}

#Preview {
    ContentView()
}
