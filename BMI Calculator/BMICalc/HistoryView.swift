//
//  HistoryView.swift
//  BMICalc
//
//  Created by Abhishek Rane on 21/06/24.
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
                    NavigationLink("BMI: \(record.bmiCaptured) On: \(record.bmiDateCaptured.formatted(date:.abbreviated, time: .omitted))") {
                        VStack{
                            List {
                                Text("Weight: \(record.weightCaptured) \(record.weightUnitsCaptured)")
                                Text("Height \(record.heightCaptured) \(record.heightUnitsCaptured)")
                                Text("BMI: \(record.bmiCaptured)")
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
    
            
//            
//            List {
//                if (bmiRecords.records.count == 0){
//                    Text("No Records Found")
//                }
//                ScrollView{
//                    LazyVGrid(columns:layout){
//                        Text("BMI").font(.headline)
//                        Text("BMI CLASS").font(.headline)
//                        Text("DATE").font(.headline)
//                        ForEach(bmiRecords.records) { record in
//                            GridRow{
//                                Text(String(record.bmiCaptured))
//                                Text(record.bmiClassCaptured)
//                                Text(record.bmiDateCaptured.formatted())
//                            }
//                            
//                        }.onDelete(perform: deleteRecords)
//                    }
//                }
                
                
    
  
    func deleteRecords(at offsets:IndexSet){
        bmiRecords.records.remove(atOffsets: offsets)
    }
}

#Preview {
    HistoryView()
}
