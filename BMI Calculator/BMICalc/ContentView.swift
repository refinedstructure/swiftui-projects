//
//  ContentView.swift
//  BMICalc
//
//  Created by Abhishek R on 20/05/24.
//

import SwiftUI

struct ContentView: View {

//INSTANCE OF THE BMI CALCULATOR CLASS
@State private var bmiCalc = bmiCalculator()
    
    var body: some View{
        
        if bmiCalc.allDataEntered {
                Text("Your BMI is \(bmiCalc.bmi,specifier: "%.2f") ")
                    .padding()
                    .animation(.smooth, value: 100)
                    .font(.title)
                Text("Your BMI Category is \(bmiCalc.bmiClass)")
                    .padding()
                    .animation(.smooth, value: 100)
        }
        else {
            Text("Calculate Your BMI")
                .padding()
                .font(.title)
            Text("Start by entering your height and weight")
                .padding()
        }
        
        VStack {
                TextField("Enter Height", text: $bmiCalc.inputHeight)
                    .textFieldStyle(.roundedBorder)
                    .disableAutocorrection(true)
                    .keyboardType(.decimalPad)
                
                Picker("Enter height units", selection: $bmiCalc.selectedHeightUnit)
                {
                    ForEach(bmiCalc.heightUnits, id: \.self){
                        Text($0)
                    }
                }.pickerStyle(.segmented)
                
                TextField("Enter Weight", text: $bmiCalc.inputWeight)
                    .textFieldStyle(.roundedBorder)
                    .disableAutocorrection(true)
                    .keyboardType(.decimalPad)
                
                Picker("Enter weight units", selection: $bmiCalc.selectedWeightUnit)
                {
                    ForEach(bmiCalc.weightUnits, id: \.self){
                        Text($0)
                    }
                }.pickerStyle(.segmented)
            }
        .padding()
        
        HStack{
            Button{
                bmiCalc.inputHeight = ""
                bmiCalc.inputWeight = ""
            }
            label: {
                Image(systemName:"xmark.circle")
                Text("Clear")
            }
            .buttonStyle(BorderedButtonStyle())
            .foregroundStyle(.black)

//            Button("Save"){
//                
//            }
        }
        .padding(.top)
        
    }
    }

#Preview {
    ContentView()
}

