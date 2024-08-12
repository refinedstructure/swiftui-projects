//
//  Calculator.swift
//  BMICalc
//
//  Created by Abhishek Rane on 12/08/24.
//

import Foundation

@Observable

class BMI {
    
    static let weightUnits = ["kilos", "lbs"]
    static let heightUnits = ["cms", "in"]
    
    var weight = 0.0
    var height = 0.0
    
    
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
