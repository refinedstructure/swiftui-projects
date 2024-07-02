//
//  QuoteView.swift
//  Quotecards
//
//  Created by Abhishek Rane on 03/07/24.
//

import SwiftUI

struct QuoteView: View {
    
    let selectedCategory: String
    
    var body: some View {
        Text(selectedCategory)
    }
}

#Preview {
    QuoteView(selectedCategory: "Test")
}
