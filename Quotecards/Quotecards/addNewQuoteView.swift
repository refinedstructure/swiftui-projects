//
//  addNewQuoteView.swift
//  Quotecards
//
//  Created by Abhishek Rane on 10/11/24.
//
import SwiftData
import SwiftUI


struct addNewQuoteView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    
    @State private var quoteText:String = ""
    @State private var quoteAuthor:String = ""
    var body: some View {
        NavigationStack {
            Form{
                TextField("Quote", text: $quoteText)
                TextField("Author", text: $quoteAuthor)
                Button("Save"){
                    let newQuote = QuoteCard(quoteText: quoteText, quoteAuthor: quoteAuthor)
                    modelContext.insert(newQuote)
                    dismiss()
                }
                .frame(maxWidth:.infinity, alignment:.trailing)
                .buttonStyle(.borderedProminent)
                .padding(.vertical)
                .disabled(quoteText.isEmpty||quoteAuthor.isEmpty)
                .navigationTitle("New Quote")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
        
    }
}

#Preview {
    addNewQuoteView()
}
