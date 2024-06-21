//
//  HistoryView.swift
//  BMICalc
//
//  Created by Abhishek Rane on 21/06/24.
//

import SwiftUI

struct HistoryView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var bmiRecords = bmiRecordItems()
    
    var body: some View {

        NavigationStack {
            List {
                if (bmiRecords.records.count == 0){
                    Text("No Records Found")
                }
                ForEach(bmiRecords.records) { record in
                    HStack{
                        Text(String(record.bmiCaptured))
                        Text(record.bmiClassCaptured)
                        Text(record.bmiDateCaptured.formatted())
                    }
                }
                .onDelete(perform: deleteRecords)
    
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
