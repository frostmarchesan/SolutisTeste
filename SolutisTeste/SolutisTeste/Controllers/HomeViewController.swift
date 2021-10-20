//
//  ViewController.swift
//  SolutisTeste
//
//  Created by marcelo frost marchesan on 20/09/21.
//

import UIKit

class HomeScreenViewController: UIViewController {
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var invalidDataLabel: UILabel!
    
    var user : User?
//    var secondVC : SecondScreenViewController?
    var validator = LoginValidator()
    var loginRequest = ServiceRequest()
    let loginUrl = "https://api.mobile.test.solutis.xyz/login"
    let statementURL = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginTextField.textColor = .systemGray
        invalidDataLabel.isHidden = true
    }
    
    
    @IBAction func loginPressed(_ sender: UIButton) {
        var loginCheck : Bool = validator.checkUserLog(entry: loginTextField.text ?? "")
        var passwordCheck : Bool = validator.checkPassword(password: passwordTextField.text ?? "")
        
        if (loginCheck && passwordCheck) {
            loginRequest.performRequest(urlString: loginUrl, userLogin: loginTextField.text ?? "", userPassword: passwordTextField.text ?? "") { result in
                switch result{
                case .success(let userResult):
                    DispatchQueue.main.async {
                        self.user = userResult
                        self.performSegue(withIdentifier: "showSecondView", sender: self)
                    }
                case .failure(let error):
                    print(error)
                }
            }
        } else {
            loginTextField.textColor = .systemRed
            invalidDataLabel.isHidden = false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSecondView" {
            let secondVC = segue.destination as! SecondScreenViewController
            secondVC.userName = user!.nome
            secondVC.cpf = user?.cpf
            secondVC.balance = user?.saldo
        }
    }
}

