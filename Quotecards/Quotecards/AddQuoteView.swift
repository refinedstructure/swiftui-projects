//
//  AddQuoteView.swift
//  Quotecards
//
//  Created by Abhishek Rane on 17/10/24.
//

import SwiftUI
struct AddQuoteView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var quoteText = ""
    @State private var quoteAuthor = ""
    let categories = ["Books", "Movies"]
    @State private var category = "Books"
 // categories to be pulled from main db later.
    var body: some View {
        NavigationStack{
            Form{
                Section("Your Quote"){
                    TextEditor(text: $quoteText)
                }
                Section("Quote Details"){
                    TextField("Quote Author",text: $quoteAuthor)
                    Picker("Quote Category",selection: $category){
                        ForEach(categories, id:\.self) {
                        Text($0)
                        }
                        
                    }
                }
            }
        }
        
    }
}

#Preview {
    AddQuoteView()
}
