//
//  HistoryView.swift
//  BMICalc
//
//  Created by Abhishek R on 21/06/24.
//

import SwiftUI

struct HistoryView: View {
    @Environment(\.dismiss) var dismiss
//    let layout = [
//        GridItem(.adaptive(minimum: 90))
//    ]
    
    @State private var bmiRecords = bmiRecordItems()
    
    var body: some View {
        
        NavigationStack {
            List{
                ForEach(bmiRecords.records) { record in
                    NavigationLink("BMI: \(record.bmiCaptured, specifier: "%.2f") On: \(record.bmiDateCaptured.formatted(date:.abbreviated, time: .omitted))") {
                        VStack{
                            List {
                                Text("Weight: \(record.weightCaptured,specifier: "%.2f") \(record.weightUnitsCaptured)")
                                Text("Height \(record.heightCaptured,specifier: "%.2f") \(record.heightUnitsCaptured)")
                                Text("BMI: \(record.bmiCaptured, specifier: "%.2f")")
                                Text("BMI Class: \(record.bmiClassCaptured)")
                                Text("Captured on: \(record.bmiDateCaptured)")
                            }
                        }.navigationTitle("Details")
                    }
                    
                }.onDelete(perform: deleteRecords)
                
            }.navigationTitle("BMI History")
                .toolbar{
                    ToolbarItem(placement:.topBarLeading) {
                        EditButton()
                    }
                }
                .toolbar(){
                    ToolbarItem(placement:.topBarTrailing) {
                        Button("Close"){
                            dismiss()
                        }
                    }
                }
            
        }
            
        
    }
    
            
                
    
  
    func deleteRecords(at offsets:IndexSet){
        bmiRecords.records.remove(atOffsets: offsets)
    }
}

#Preview {
    HistoryView()
}
