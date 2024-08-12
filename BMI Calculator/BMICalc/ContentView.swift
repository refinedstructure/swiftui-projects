//
//  ContentView.swift
//  BMICalc
//
//  Created by Abhishek R on 20/05/24.
//

import SwiftUI

struct ContentView: View {
    
    enum fieldEmptyError: Error{
        case height, weight, both
    }
    @State private var fieldErrorText = ""
    
    @AppStorage("weight") private var weight = 0.0
    let weightUnits = ["kilos", "pounds"]
    let heightUnits = ["cms", "inches"]
    @AppStorage("weightUnits") private var selectedWeightUnit = ""
    
    @AppStorage("height") private var height = 0.0
 
    @AppStorage("heightUnits") private var selectedHeightUnit = ""
    

    @State private var alertTitle = ""
    @State private var alertText = ""
    
    @State private var latestBMI:Double = 0.0
    

    
    //HISTORY
    @State private var showingHistory = false
    
    @State private var bmiRecords = bmiRecordItems()
    
    @State private var calculatePressed = false

    
    @State private var showingErrorToast = false
    
    @State private var zeroFields = [Bool]()
    
    
    var disableCalculate: Bool {
        weight == 0.0 || height == 0
    }
    var body:some View {
        VStack {
            Form{
                Text("BMI Calculator")
                    .listRowBackground(Color.clear)
                    .font(.title)
                    .fontWidth(.standard)
                    .foregroundStyle(.blue.gradient)
                    .frame(maxWidth:.infinity, alignment: .center)
                    .background(.clear)
                
                Section("Weight") {
                    
                    HStack {
                        TextField("Enter your weight", value:$weight, format:.number)
                            .keyboardType(.decimalPad)
                        
                        Text(weight <= 0 ? "Can't be zero or empty" : selectedWeightUnit)
                            .font(.caption)
                            .foregroundColor(weight <= 0 ? .red : .black)
                    }
                
                }
                Section("Select Weight Units") {
                    Picker("", selection: $selectedWeightUnit)
                    {
                        ForEach(weightUnits, id: \.self){
                            Text($0)
                        }
                        
                    }.pickerStyle(.segmented)
                    
                    
                    
                }
                Section("Height") {
                    
                    HStack {
                        TextField("Enter your height", value:$height, format:.number)
                            .keyboardType(.decimalPad)
                        
                        Text(height <= 0 ? "Can't be zero or empty" : selectedHeightUnit)
                            .font(.caption)
                            .foregroundColor(height <= 0 ? .red : .black)
                    }
                    
                }
                Section("Select Height Units"){
                    Picker("", selection: $selectedHeightUnit){
                        ForEach(heightUnits, id: \.self){
                            Text($0)
                        }
                        
                    }.pickerStyle(.segmented)
                }
            }

                
            HStack{
                Button("History", systemImage: "chart.bar")
                {
                    showingHistory.toggle()
                    
                }.sheet(isPresented: $showingHistory){
                    HistoryView()
                }
                .buttonStyle(BorderedButtonStyle())
                .clipShape(Capsule())
                .foregroundColor(.black)
                .overlay(Capsule().stroke(LinearGradient(colors: [Color(.blue), Color(.gray), Color(.blue)], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 2.0))
                .controlSize(.large)
                
                
                
                Button("Calculate", systemImage: "lines.measurement.vertical")
                {
                   
                
                    }
                    .disabled(disableCalculate)
                    
                    .buttonStyle(BorderedButtonStyle())
                    .clipShape(Capsule())
                    .foregroundColor(.black)
                    .overlay(Capsule().stroke(LinearGradient(colors: [Color(.blue), Color(.yellow), Color(.blue)], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 2.0))
                    .controlSize(.large)
                }
                
                .alert("BMI", isPresented: $calculatePressed)
                {
                    Button("Don't Save", role:.cancel) {
                        latestBMI = 0.0
                        calculatePressed = false
                    }
                    Button("Save") {
//                        let savedRecord = bmiHistoryRecords(weightCaptured: weight, heightCaptured: height, weightUnitsCaptured: selectedWeightUnit, heightUnitsCaptured: selectedHeightUnit, bmiCaptured: latestBMI, bmiClassCaptured: bmiClass(bmi: latestBMI), bmiDateCaptured: Date())
//                        bmiRecords.records.insert(savedRecord, at: 0)
                        calculatePressed = false
                        latestBMI = 0.0
                        resetFields()
                    }
                }
            message: {
                Text(alertText)
            }
       
        }.alert(fieldErrorText, isPresented: $showingErrorToast) {
           
        }

        }

    
    func resetFields() {
        selectedHeightUnit = ""
        selectedWeightUnit = ""
        //        height = 0.0
        //        weight = 0.0
    }
    
   

    
    
}
    


#Preview {
    ContentView()
}


//
//BMI Categories:
//Underweight = <18.5
//Normal weight = 18.5–24.9
//Overweight = 25–29.9
//Obesity = BMI of 30 or greater
