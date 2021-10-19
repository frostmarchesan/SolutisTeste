//
//  LoginValidator.swift
//  SolutisTeste
//
//  Created by Virtual Machine on 19/10/21.
//

import Foundation

struct LoginValidator {
    let emailPattern = #"ˆ\S+@\S+\.\S+$"#
    let cpfPattern = ""
    let passwordPattern = ""
}

//MARK: - checkEmail
extension LoginValidator {

    func checkEmail(email: String) -> Bool{
        let result = email.range(
            of: emailPattern,
            options: .regularExpression
        )
        if (result != nil) {
            return true
        }
        return false
    }
}

//MARK: - checkCPF
extension LoginValidator {

    func checkCPF(cpf: String) -> Bool{
        var sum = 0
        var result = 0
        let cpfNumbers = Int(cpf)
        
        
        
        
      if (strCPF == "00000000000") return false;

      for (i=1; i<=9; i++) Soma = Soma + parseInt(strCPF.substring(i-1, i)) * (11 - i);
      Resto = (Soma * 10) % 11;

        if ((Resto == 10) || (Resto == 11))  Resto = 0;
        if (Resto != parseInt(strCPF.substring(9, 10)) ) return false;

      Soma = 0;
        for (i = 1; i <= 10; i++) Soma = Soma + parseInt(strCPF.substring(i-1, i)) * (12 - i);
        Resto = (Soma * 10) % 11;

        if ((Resto == 10) || (Resto == 11))  Resto = 0;
        if (Resto != parseInt(strCPF.substring(10, 11) ) ) return false;
        return true;
    }
    var strCPF = "12345678909";
    alert(TestaCPF(strCPF));
    </script>
        
        
        
        
        
        let result = cpf.range(
            of: emailPattern,
            options: .regularExpression
        )
        if (result != nil) {
            return true
        }
        return false
    }
}

//MARK: - checkPassword
extension LoginValidator {

    func checkPassword(password: String) -> Bool{
        let result = password.range(
            of: emailPattern,
            options: .regularExpression
        )
        if (result != nil) {
            return true
        }
        return false
    }
}
