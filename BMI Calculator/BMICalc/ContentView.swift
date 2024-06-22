//
//  ContentView.swift
//  BMICalc
//
//  Created by Abhishek Rane on 20/05/24.
//

import SwiftUI


struct bmiHistoryRecords:Identifiable, Codable{
    var id = UUID()
    let weightCaptured:Double
    let heightCaptured:Double
    let weightUnitsCaptured:String
    let heightUnitsCaptured: String
    let bmiCaptured: Double
    let bmiClassCaptured: String
    let bmiDateCaptured:Date
}

@Observable
class bmiRecordItems {
    var records = [bmiHistoryRecords]() {
        didSet {
            if let encoded = try?
                JSONEncoder().encode(records) {
                UserDefaults.standard.set(encoded,
                                          forKey: "Records")
            }
        }
    }
    
    init() {
        if let savedRecords =
            UserDefaults.standard.data(forKey: "Records") {
            if let decodedItems = try?
                JSONDecoder().decode(
                    [bmiHistoryRecords].self, from:
                        savedRecords) {
                records = decodedItems
                return
            }
        }
}
}


struct ContentView: View {
    
    @AppStorage("weight") private var weight = 0.0
    let weightUnits = ["kilos", "pounds"]
    
    @AppStorage("weightUnits") private var selectedWeightUnit = ""
    
    @AppStorage("height") private var height = 0.0
    let heightUnits = ["cms", "inches"]
    @AppStorage("heightUnits") private var selectedHeightUnit = ""
    
    @State private var unitsSelected = false
    @State private var resultsDisplayed = false
    @State private var unitsMatch = false
    
    @State private var alertTitle = ""
    @State private var alertText = ""
    
    @State private var latestBMI:Double = 0.0
    
    //HISTORY
    @State private var showingHistory = false
    
    @State private var bmiRecords = bmiRecordItems()
    
    @State private var calculatePressed = false
    
    @State private var heightEmpty = true
    @State private var weightEmpty = true
    @State private var heightNotSelected = true
    @State private var weightNotSelected = true
    
    @State private var zeroFields = [Bool]()
    
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
                        unitsSelected = areUnitsPicked(heightUnits: selectedHeightUnit, weightUnits: selectedWeightUnit)
                        unitsMatch = doUnitsMatch(heightUnits: selectedHeightUnit, weightUnits: selectedWeightUnit)
                        //                            PENDING - ZERO VALUES on weight and height
                        
                        if (unitsSelected && unitsMatch)
                        {
                            latestBMI = calculateBMI(height: height, weight: weight, weightUnit: selectedWeightUnit)
                            calculatePressed = true
                            alertText = """
                            Your BMI: \(latestBMI)
                            Your BMI class: \(bmiClass(bmi: latestBMI))
                            """
                        
                            resetFields()
                        }
                        
                        
                    }
                    
                    .buttonStyle(BorderedButtonStyle())
                    .clipShape(Capsule())
                    .foregroundColor(.black)
                    .overlay(Capsule().stroke(LinearGradient(colors: [Color(.blue), Color(.yellow), Color(.blue)], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 2.0))
                    .controlSize(.large)
                }
                
                .alert("BMI", isPresented: $calculatePressed)
                {
                    Button("Close",role:.cancel) {
                        latestBMI = 0.0
                        calculatePressed = false
                    }
                    Button("Save") {
                        let savedRecord = bmiHistoryRecords(weightCaptured: weight, heightCaptured: height, weightUnitsCaptured: selectedWeightUnit, heightUnitsCaptured: selectedHeightUnit, bmiCaptured: latestBMI, bmiClassCaptured: bmiClass(bmi: latestBMI), bmiDateCaptured: Date())
                        bmiRecords.records.insert(savedRecord, at: 0)
                        latestBMI = 0.0
                        calculatePressed = false
                    }
                }
            message: {
                Text(alertText)
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
