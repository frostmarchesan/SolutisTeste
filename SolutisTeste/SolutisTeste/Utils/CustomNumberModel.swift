//
//  CustomNumberModel.swift
//  SolutisTeste
//
//  Created by marcelo frost marchesan on 21/10/21.
//

import Foundation

struct CustomNumberModel {
    
    func currencyConverter (amount: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = Locale(identifier: "br_BR")
        return numberFormatter.string(from: NSNumber(value: amount))?.replacingOccurrences(of: "R$", with: "") ?? "0.0"
    }
}
