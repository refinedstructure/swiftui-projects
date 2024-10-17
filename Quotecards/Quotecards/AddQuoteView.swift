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

    var body: some View {
        NavigationStack{
            Form{
                Section{
                    TextEditor(text: $quoteText)
                }
            }
        }
        
    }
}

#Preview {
    AddQuoteView()
}
