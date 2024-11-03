////
////  AddQuoteView.swift
////  Quotecards
////
////  Created by Abhishek Rane on 17/10/24.
////
//import SwiftData
//import SwiftUI
//
//struct AddQuoteView: View {
//    @Environment(\.dismiss) var dismiss
//    @Environment(\.modelContext) var modelContext
//    
//    @Query var categories: [quoteCategories]
//
//    @State private var id = 11
//    @State private var quoteText = ""
//    @State private var quoteAuthor = ""
//    @State private var quoteBookmarkStatus = false
//    @State private var quoteCategory: Category
//    
//    var body: some View {
//        NavigationStack {
//            Form {
//                Section(header: Text("Quote Details")) {
//                    TextEditor(text: $quoteText)
//                        .frame(height: 100)
//                    TextField("Quote Author", text: $quoteAuthor)
//                    Picker("Quote Category", selection: $quoteCategory) {
//                        ForEach(categories) { category in
//                            Text(category.name)
//                        }
//                    }
//                }
//                
//                Section {
//                    Button("Save") {
//                        let newQuote = QuoteCard(quoteText: quoteText, quoteCategory: quoteCategory, quoteAuthor: quoteAuthor, quoteBookmarkStatus: quoteBookmarkStatus)
//                        modelContext.insert(newQuote)
//                        dismiss()
//                    }
//                }
//            }
//            .navigationTitle("Add New Quote")
//        }
//    }
//}
//
//
//#Preview {
//    AddQuoteView()
//}
