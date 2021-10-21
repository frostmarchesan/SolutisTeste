//
//  CustomNumberModel.swift
//  SolutisTeste
//
//  Created by marcelo frost marchesan on 21/10/21.
//

import Foundation

struct CustomNumberModel {
    
    func getNumber (amount: Double) -> String {
        var textAmount = String(format: "%.2f", amount)
        textAmount = textAmount.replacingOccurrences(of: ".", with: ",")
        var count = 6
        while (textAmount.count > count) {
            if (textAmount.count > count) {
                textAmount.insert(".", at: textAmount.index(textAmount.endIndex, offsetBy: -count))
            }
            count += 4
        }
        return textAmount
    }
}
