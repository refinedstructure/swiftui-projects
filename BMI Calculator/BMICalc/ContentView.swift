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
    
  
        TextField("Height", text: $bmiCalc.inputHeight)
            .textFieldStyle(.roundedBorder)
            .disableAutocorrection(true)
        
        Picker("Enter height units", selection: $bmiCalc.selectedHeightUnit)
        {
            ForEach(bmiCalc.heightUnits, id: \.self){
                Text($0)
            }
        }.pickerStyle(.segmented)
        
        TextField("Weight", text: $bmiCalc.inputWeight)
                .textFieldStyle(.roundedBorder)
                .disableAutocorrection(true)
        
        Picker("Enter weight units", selection: $bmiCalc.selectedWeightUnit)
        {
            ForEach(bmiCalc.weightUnits, id: \.self){
                Text($0)
            }
        }.pickerStyle(.segmented)
        
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
