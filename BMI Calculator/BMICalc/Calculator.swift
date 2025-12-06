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
    

  
    
    var allDataEntered: Bool {
        if inputHeight.isEmpty || inputWeight.isEmpty {
            return false
        }
        return true
    }
    
    var bmi:Double {
            let bmi = calculateBMI(inputHeight: inputHeight, inputWeight: inputWeight, weightUnit: selectedWeightUnit, heightUnit: selectedHeightUnit)
            return bmi
    }
    
    var bmiClass: String{
        let bmiClass = bmiClass(bmi: bmi)
        return bmiClass
    }

    
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
    
    
    func bmiClass(bmi: Double) -> String {
        switch bmi {
        case ..<0:
            return "Invalid BMI"
        case 0..<18.5:
            return "Underweight"
        case 18.5..<25:
            return "Normal weight"
        case 25..<30:
            return "Overweight"
        case 30..<35:
            return "Obese Class I"
        case 35..<40:
            return "Obese Class II"
        case 40...:
            return "Obese Class III (Morbidly Obese)"
        default:
            return "NA"
        }
    }
    
}


