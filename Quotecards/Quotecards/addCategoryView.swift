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

    let icons = ["popcorn", "music.note","play.laptopcomputer", "quote.bubble", "book", "figure.badminton","person"]
    let colors = ["red", "blue", "green", "yellow"]
    @State private var selectedColor = "blue"
    @State private var selectedIcon = "quote.bubble"
    
    
    var body: some View {
        NavigationStack{
            Form{
                TextField("Category Name", text: $name)
                TextField("Category Description", text: $descriptionText)
               
                Text("Icon")
                     .font(.subheadline)
                     .foregroundColor(.secondary)
                Picker("Category Icon", selection: $selectedIcon) {
                    ForEach(icons, id:\.self){
                        Image(systemName: $0)
                    }
                }.pickerStyle(.segmented)
                
                Text("Category Color")
                     .font(.subheadline)
                     .foregroundColor(.secondary)

                Picker("Select a color", selection: $selectedColor){
                    ForEach(colors, id:\.self){
                        Text($0)
                    }
                }
                .pickerStyle(.automatic)
                
                Button("Save") {
                    let newCategory = Collection(name: name, descriptionText: descriptionText, icon: selectedIcon, baseColor: selectedColor)
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
