//
//  ContentView.swift
//  BMICalc
//
//  Created by Abhishek Rane on 20/05/24.
//

import SwiftUI



struct historyView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View{
       
        Button("",systemImage: "chevron.down") {
            
            dismiss()
        }
        Text("BMI History").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            
        
    }
}




struct ContentView: View {
    @State private var weight = 0.0
    let weightUnits = ["kilos", "pounds"]
    
    @State private var selectedWeightUnit = ""
    
    @State private var height = 0.0
    let heightUnits = ["cms", "inches"]
    @State private var selectedHeightUnit = ""
    
    @State private var unitsSelected = false
    @State private var resultsDisplayed = false
    @State private var unitsMatch = false
    
    @State private var alertTitle = ""
    @State private var alertText = ""
    
    @State private var latestBMI:Double = 0.0
    
    //HISTORY
    @State private var bmiHistory = [Double]()
    @State private var dates = [Date]()
    
    @State private var calculatePressed = false
    
    @State private var showHistory = false
    
    @State private var heightEmpty = true
    @State private var weightEmpty = true
    @State private var heightNotSelected = true
    @State private var weightNotSelected = true
    
    @State private var showingHistory = false
    
    @State private var cardFront = false
    
    @State private var zeroFields = [Bool]()
    
    var body:some View {
    
            ZStack{
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
                                Text(selectedWeightUnit)
                                    .font(.caption)
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
                                Text(selectedHeightUnit)
                                    .font(.caption)
                            }
                            
                        }
                        Section("Select Height Units"){
                            Picker("", selection:$selectedHeightUnit){
                                ForEach(heightUnits, id: \.self){
                                    Text($0)
                                }
                                
                            }.pickerStyle(.segmented)
                            
                        }

                    }

                   
                        
//                      
                 
                        Button("Show History", systemImage: "chart.bar")
                        {
                            showingHistory.toggle()
                            
                        }.sheet(isPresented: $showingHistory){
                            
                            historyView()
                            
                            List {
                                
                                ForEach(bmiHistory, id: \.self) {record in
                                    HStack{
                                        Text(Date.now, format: .dateTime.day().month().year())
                                        Text(String(format: "%.2f", record))
                                        Text(bmiClass(bmi: record))
                                        
                                        Button("", systemImage:"trash.circle"){
                                            bmiHistory.remove(at: bmiHistory.firstIndex(of: record) ?? 0)
                                        }
                                    }
                                }
                            }
                        }
                        
                        
                        Button("Calculate", systemImage: "play.fill")
                        {
                            
                            unitsSelected = areUnitsPicked(heightUnits: selectedHeightUnit, weightUnits: selectedWeightUnit)
                            unitsMatch = doUnitsMatch(heightUnits: selectedHeightUnit, weightUnits: selectedWeightUnit)
                            
                            //                            PENDING - ZERO VALUES on weight and height
                            
                            
                            
                            if (unitsSelected && unitsMatch)
                            {
                                latestBMI = calculateBMI(height: height, weight: weight, weightUnit: selectedWeightUnit)
                                calculatePressed = true
                                alertText = "Your BMI is \(latestBMI)"
                                resetFields()
                            }
                            
                            
                        }
                        .buttonStyle(BorderedButtonStyle())
                        .clipShape(Capsule())
                        .foregroundColor(.black)
                        .overlay(Capsule().stroke(LinearGradient(colors: [Color(.black), Color(.red), Color(.black)], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 2.0))
                        .controlSize(.large)
                        .padding(10)
                        
                        .alert(alertText, isPresented: $calculatePressed)
                        {
                            Button("ok",role:.cancel) {
                                storeBMIs(bmi: latestBMI)
                                latestBMI = 0.0
                                calculatePressed = false
                                
                            }
                            
                        }
                    


                        }
                           
                }
                }
     
    
    
    func resetFields() {
        selectedHeightUnit = ""
        selectedWeightUnit = ""
//        height = 0.0
//        weight = 0.0
    }
    
    func findZeroFields(height: Double, weight:Double) -> Array<Bool>
    {
        var emptyFields = [Bool]()
        
        if weight == 0 {
            weightEmpty = true
            emptyFields.append(weightEmpty)
        }
        else if height == 0 {
            heightEmpty = true
            emptyFields.append(heightEmpty)
        }
        
        return emptyFields
    }
        
    
    func areUnitsPicked(heightUnits:String, weightUnits:String) -> Bool{
        var unitStatus = true
        if(heightUnits == "" || weightUnits == ""){
            unitStatus = false
        }
        else {
            unitStatus = true
        }
        return unitStatus
    }
    

    func doUnitsMatch(heightUnits:String, weightUnits:String) -> Bool {
        
        var unitsCorrect = false
        if (heightUnits == "cms" && weightUnits == "kilos") {
           unitsCorrect = true
        }
        else if (heightUnits == "inches" && weightUnits == "pounds"){
            unitsCorrect = true
        }
        else{
            unitsCorrect = false
        }
        return unitsCorrect
    }
    
    func calculateBMI( height: Double, weight:Double, weightUnit: String) -> Double
    {
        var bmi = 0.0
        if(weightUnit == "kilos") {
            
            bmi = ((weight)/((height/100) * (height/100)))
            bmi = round(bmi * 100)/100.0
        
        }
        else if (weightUnit == "pounds")
        {
            
            bmi = ((weight)/(height * height)) * 703
            bmi = round(bmi * 100)/100.0
            
        }
        return bmi
    }
    
    func storeBMIs(bmi:Double){
        
        guard bmi > 0 else {return}
        
            bmiHistory.insert(bmi, at: 0)
            dates.insert(Date.now, at:0)
        
            if (bmiHistory.count > 3 && dates.count > 3){
                bmiHistory.removeLast()
                dates.removeLast()
            }
        if (bmiHistory.count > 0 ){
            withAnimation{
                showHistory = true
            }}
    }
    
    func bmiClass(bmi:Double)-> String{
        var bmiClass = ""
        switch bmi {
        case 0...18.5:
            bmiClass = "Underweight"
        case 18.5...24.9:
            bmiClass = "Normal weight"
        case 25...29.9:
            bmiClass = "Overweight"
        case 30...100:
            bmiClass = "Obese"
        default:
            bmiClass = "NA"
        }
        return bmiClass
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
