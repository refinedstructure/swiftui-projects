//
//  ContentView.swift
//  BMICalc
//
//  Created by Abhishek Rane on 20/05/24.
//

import SwiftUI

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
    
    
    var body:some View {
    
            ZStack{
                VStack {
           
                    Form{
                            Text("BMI Calculator")
                                .listRowBackground(Color.clear)
                                .font(.title)
                                .fontWidth(.standard)
                                .fontDesign(.serif)
                                .foregroundStyle(.brown.gradient)
                            
                        
                        Section("Weight") {
                            TextField("Enter your weight", value:$weight, format:.number)
                                .keyboardType(.decimalPad)
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
                            TextField("Enter your height", value:$height, format:.number)
                                .keyboardType(.decimalPad)
                            
                            
                        }
                        Section("Select Height Units"){
                            Picker("", selection:$selectedHeightUnit){
                                ForEach(heightUnits, id: \.self){
                                    Text($0)
                                }
                                
                            }.pickerStyle(.segmented)
                            
                        }
                        
                        if showHistory {
                            Section("BMI History (last 3)") {
                                List {
                                    ForEach(bmiHistory, id: \.self) {record in
                                        HStack{
                                            Text(Date.now, format: .dateTime.day().month().year())
                                            Text(String(format: "%.2f", record))
                                            Text(bmiClass(bmi: record))
                                                                                }
                                    }
                                }
                                
                  
                                
                            }

                        }
                        
                        
                    }
                    
                    
                }


                
                VStack{
    
                    Spacer()

                    HStack {
                        Button("Calculate", systemImage: "play.fill")
                        {
                            unitsSelected = areUnitsPicked(heightUnits: selectedHeightUnit, weightUnits: selectedWeightUnit)
                            unitsMatch = doUnitsMatch(heightUnits: selectedHeightUnit, weightUnits: selectedWeightUnit)
                            
                            calculatePressed = true
                            
                            if (height == 0 || weight == 0)
                            {
                                var whatIsEmpty = ""
                                if (weight == 0 && height > 0) {
                                    whatIsEmpty = "weight"
                                }
                                else if (height == 0 && weight > 0 ) {
                                    whatIsEmpty = "height"
                                }
                                else {
                                    whatIsEmpty = "height and weight"
                                }
                                
                                alertTitle = "\(whatIsEmpty) can't be empty"
                                alertText = "Please enter \(whatIsEmpty)"
                                
                            }
                            else if (unitsSelected == false)
                            {
                                alertTitle = "Select all units"
                                alertText = "Make sure both units are selected"
                            }
                            
                            else if(unitsMatch == false && unitsSelected == true) {
                                
                                var desiredHeightUnit = ""
                                if(selectedWeightUnit == "kilos") {
                                    desiredHeightUnit = "cms"
                                }
                                else{
                                    desiredHeightUnit = "inches"
                                }
                                
                                alertTitle = "Check units"
                                alertText = "If your weight is in \(selectedWeightUnit), height should be in \(desiredHeightUnit)"
                            }
                            
                            else if (unitsMatch == true && unitsSelected == true){
                                alertTitle = "BMI"
                                latestBMI = calculateBMI(height: height, weight: weight, weightUnit: selectedWeightUnit)
                                     alertText = "Your BMI is \(latestBMI)"
                                    //                                RESET THE FIELDS WHEN calculation is done
                                
                                resetFields()
                            }
                            
                        }
                        .buttonStyle(BorderedButtonStyle())
                        .clipShape(Capsule())
                            .foregroundColor(.black)
                            .overlay(Capsule().stroke(LinearGradient(colors: [Color(.black), Color(.systemBlue), Color(.black)], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 4.0))
                            .controlSize(.large)
                             .padding(10)
                        
                            .alert(alertText, isPresented: $calculatePressed)
                        {
                            Button("ok",role:.cancel) {
                                
                                withAnimation(.smooth){
                                    
                                    storeBMIs(bmi: latestBMI)
                                    latestBMI = 0.0
                                    calculatePressed = false
                                }
                            }

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
            bmiClass = "No category"
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
