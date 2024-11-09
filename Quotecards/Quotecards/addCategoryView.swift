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
        NavigationStack{
            Form{
                TextField("Category Name", text: $name)
                TextField("Description", text: $descriptionText)
                TextField("Icon", text: $icon)
                //                TODO- show sf symbols here
                TextField("Color", text: $baseColor)
                Button("Save") {
                    let newCategory = Category(name: name, descriptionText: descriptionText, icon: icon, baseColor: baseColor)
                    modelContext.insert(newCategory)
                    dismiss()
                    
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .buttonStyle(.borderedProminent)
                .padding(.vertical)
                .disabled(name.isEmpty || descriptionText.isEmpty)
                .navigationTitle("New Category")
                .navigationBarTitleDisplayMode(.inline)
            }}
        
}
}

#Preview {
    addCategoryView()
}
