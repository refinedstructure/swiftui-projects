//
//  BMIRecords.swift
//  BMICalc
//
//  Created by Abhishek Rane on 11/08/24.
//

import Foundation
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
