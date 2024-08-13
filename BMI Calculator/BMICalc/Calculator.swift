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
    
    
   func calculateBMI(height: inout Double,  weight: inout Double, weightUnit: String, heightUnit: String) -> Double
    {
        switch heightUnit {
        case "ft":
                height *= 12
        case "cms":
            height *= 0.393701
        case "in":
            fallthrough
        default:
            height = 1
        }
        
        switch weightUnit {
        case "kilos":
            weight *= 2.20462
        case "lbs":
            fallthrough
        default:
            weight = 1
        }
        
        var bmi = 0.0
        bmi = (weight) / (height * height) * 703
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


