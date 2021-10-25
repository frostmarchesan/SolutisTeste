//
//  LoginValidator.swift
//  SolutisTeste
//
//  Created by Virtual Machine on 19/10/21.
//

import Foundation

struct LoginValidator {
    let emailRegex = "[A-Z0-9a-z.-_]+@[A-Z0-9a-z.-_]+\\.[A-Z0-9a-z.-_]"
    let passwordRegex = "(?=.*[a-z])(?=.*[!@#$%&*])(?=.*[0-9]).{6,}"
    
    func checkUserLog(entry: String) -> Bool {
        if (checkEmail(email: entry)) {
            return true
        } else {
            return checkCPF(cpf: entry)
        }
    }
}

//MARK: - checkEmail
extension LoginValidator {
    
    func checkEmail(email: String) -> Bool{
        do {
            let regex = try NSRegularExpression(pattern: emailRegex)
            let nsString = email as NSString
            let results = regex.matches(in: email, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0 {
                return false
            }
        } catch let error as NSError {
            print("invalid Regex \(error.localizedDescription)")
            return false
        }
        return true
    }
}

//MARK: - checkCPF
extension LoginValidator {

    func checkCPF(cpf: String) -> Bool{
        var cpfArray : [Int] = []
        // convert cpf string to an array of Int
        for letter in cpf {
            cpfArray.append(letter.wholeNumberValue ?? 0)
        }
        if (!checkCpfSize(cpfArray: cpfArray)){
            return false
        }
        if (!checkAllNumbersValidation(cpfArray: cpfArray)){
            return false
        }
        if (!checkFirstValidationDigit(cpfArray: cpfArray)){
            return false
        }
        if (!checkSecondValidationDigit(cpfArray: cpfArray)){
            return false
        }
        return true;
    }
    
    func checkCpfSize (cpfArray : [Int]) -> Bool {
        if (cpfArray.count != 11) {
            return false
        }
        return true
    }
    
    // check if all numbers are equal to return an invalid cpf
    func checkAllNumbersValidation (cpfArray : [Int]) -> Bool {
        if (cpfArray.allSatisfy { $0 == cpfArray.first }) {
            return false
        }
        return true
    }
    
    func checkFirstValidationDigit (cpfArray : [Int]) -> Bool {
        var sum = 0
        var result = 0
        var multiplier = 10
        
        for numbers in 0...9 {
            sum = sum + (cpfArray[numbers] * multiplier)
            multiplier -= 1
            result = (sum * 10) % 11
        }
        if (result == 10 || result == 11) {
            result = 0
        }
        if (result == cpfArray[9] || result == cpfArray[10]) {
            return false
        }
        return true
    }
    
    func checkSecondValidationDigit (cpfArray : [Int]) -> Bool {
        var sum = 0
        var result = 0
        var multiplier = 11

        for numbers in 0...10 {
            sum = sum + (cpfArray[numbers] * multiplier)
            multiplier -= 1
            result = (sum * 10) % 11
        }
        if (result == 10 || result == 11) {
            result = 0
        }
        if (result == cpfArray[10] || result == cpfArray[11]) {
            return false
        }
        return true
    }
}

//MARK: - checkPassword
extension LoginValidator {

    func checkPassword(password: String) -> Bool{
        let regexCheck = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        let result = regexCheck.evaluate(with: password)
        return result
    }
}
