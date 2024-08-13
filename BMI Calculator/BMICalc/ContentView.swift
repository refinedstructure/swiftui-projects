//
//  ContentView.swift
//  BMICalc
//
//  Created by Abhishek R on 20/05/24.
//

import SwiftUI

struct ContentView: View {
//    INPUT GATHERED FROM USERS
@State private var weightString = ""
@State private var heightString = ""
@State private var neckCircumfString = ""
@State private var waistCircumfString = ""

//INSTANCE OF THE BMI CALCULATOR CLASS
let bmiCalc = bmiCalculator()


    var body: some View{
        
        
    TextField("Weight", text: $weightString)
            .textFieldStyle(.roundedBorder)
            .disableAutocorrection(true)
    TextField("Height", text: $heightString)
            .textFieldStyle(.roundedBorder)
            .disableAutocorrection(true)
        
    TextField("Neck circumference", text: $neckCircumfString)
        .textFieldStyle(.roundedBorder)
        .disableAutocorrection(true)
    TextField("Waist Circumference", text: $waistCircumfString)

        
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
