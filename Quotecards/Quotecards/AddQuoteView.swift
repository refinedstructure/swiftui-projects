//
//  AddQuoteView.swift
//  Quotecards
//
//  Created by Abhishek Rane on 17/10/24.
//
import SwiftData
import SwiftUI

struct AddQuoteView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext

    @State private var id = 11
    @State private var quoteText = ""
    @State private var quoteAuthor = ""
    let categories = ["Books", "Movies"]
    @State private var quoteCategory = "Books"
    @State private var quoteBookmarkStatus = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Quote Details")) {
                    TextEditor(text: $quoteText)
                        .frame(height: 100)
                    TextField("Quote Author", text: $quoteAuthor)
                    Picker("Quote Category", selection: $quoteCategory) {
                        ForEach(categories, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section {
                    Button("Save") {
                        let newQuote = QuoteCard(quoteText: quoteText, quoteCategory: quoteCategory, quoteAuthor: quoteAuthor, quoteBookmarkStatus: quoteBookmarkStatus)
                        modelContext.insert(newQuote)
                        dismiss()
                    }
                }
            }
            .navigationTitle("Add New Quote")
        }
    }
}


#Preview {
    AddQuoteView()
}
