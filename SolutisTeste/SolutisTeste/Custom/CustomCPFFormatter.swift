//
//  CustomCPFFormatter.swift
//  SolutisTeste
//
//  Created by marcelo frost marchesan on 21/10/21.
//

import Foundation

struct CustomCPFFormatter {
    func cpfFormatter (cpfString: String) -> String {
        var cpfArray : [Character] = []
        // convert cpf string to an array of Int
        for letter in cpfString {
            cpfArray.append(letter)
        }
        cpfArray.insert(".", at: 3)
        cpfArray.insert(".", at: 7)
        cpfArray.insert("-", at: 11)
        return String(cpfArray)
    }
}
