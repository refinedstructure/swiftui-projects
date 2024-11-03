//
//  addCategoryView.swift
//  Quotecards
//
//  Created by Abhishek Rane on 03/11/24.
//
import SwiftData
import SwiftUI

struct addCategoryView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    @State private var name: String = ""
    @State private var descriptionText: String = ""
    @State private var icon: String = ""
    @State private var baseColor: String = ""
    
    var body: some View {
        
        NavigationStack {
            Form{
                TextField("Category Name", text: $name)
                TextField("Description", text: $descriptionText)
                TextField("Icon", text: $icon)
                TextField("Color", text: $baseColor)
            }
            
            Button("Save") {
                let newCategory = Category(name: name, descriptionText: descriptionText, icon: icon, baseColor: baseColor)
                modelContext.insert(newCategory)
                dismiss()
            }
        } .navigationTitle("Add New Category")
       
    }
}

#Preview {
    addCategoryView()
}
