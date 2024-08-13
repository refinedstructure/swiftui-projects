//
//  Calculator.swift
//  BMICalc
//
//  Created by Abhishek Rane on 12/08/24.
//

import Foundation

@Observable
class bmiCalculator {
    let weightUnits = ["kilos", "lbs"]
    let heightUnits = ["cms", "in", "ft"]
    
    var inputWeight = ""
    var inputHeight = ""
    
    var selectedHeightUnit = "cms"
    var selectedWeightUnit = "kilos"
    
    var bmi = 0.0
    var bmiClass = ""
    
   func calculateBMI(inputHeight: String,  inputWeight: String, weightUnit: String, heightUnit: String) -> Double
    {
        var height = Double(inputHeight) ?? 0.0
        var weight = Double(inputWeight) ?? 0.0
        switch heightUnit {
        case "ft":
                height *= 12
        case "cms":
            height *= 0.393701
        case "in":
            break
        default:
            height = 1
        }
        
        switch weightUnit {
        case "kilos":
            weight *= 2.20462
        case "lbs":
            break
        default:
            weight = 1
        }
        
      
        let bmi = (weight) / (height * height) * 703
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


