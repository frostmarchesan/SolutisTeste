//
//  ViewController.swift
//  SolutisTeste
//
//  Created by marcelo frost marchesan on 20/09/21.
//

import UIKit
import KeychainSwift
import CircleLoading

class HomeScreenViewController: UIViewController {
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var invalidDataLabel: UILabel!
    
    var saveUser : Bool = true
    var user : User?
    var validator = LoginValidator()
    var loginRequest = ServiceRequest()
    var customCPF = CustomCPFFormatter()
    let keyChain = KeyChainModel()
    let image = UIImageView()
    let circle = CircleLoading()
    let loginUrl = "https://api.mobile.test.solutis.xyz/login"
    let statementURL = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginTextField.textColor = .systemGray
        invalidDataLabel.isHidden = true
        if (keyChain.getData(key: "userLogin") != "") {
            loginTextField.text = keyChain.getData(key: "userLogin")
        }
    }
    
    @IBAction func saveUserLoginSwitch(_ sender: UISwitch) {
        if (sender.isOn) {
            saveUser = true
        } else {
            saveUser = false
        }
        
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        
//        showPopUpAlert()
            
        var loginCheck : Bool = validator.checkUserLog(entry: loginTextField.text ?? "")
        var passwordCheck : Bool = validator.checkPassword(password: passwordTextField.text ?? "")
        
        if (loginCheck && passwordCheck) {
            loginRequest.performLoginRequest(urlString: loginUrl, userLogin: loginTextField.text ?? "", userPassword: passwordTextField.text ?? "") { result in
                switch result{
                case .success(let userResult):
                    DispatchQueue.main.async {
                        if (self.saveUser) {
                            self.keyChain.storeData(data: self.loginTextField.text ?? "", key: "userLogin")
                        } else {
                            self.keyChain.eraseData(key: "userLogin")
                        }
                        self.passwordTextField.text = ""
                        self.circle.stop()
                        
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
            let sec : Double = 5.0
            DispatchQueue.main.asyncAfter(deadline: .now() + sec) { [self] in
                loginTextField.textColor = .systemGray
                invalidDataLabel.isHidden = true
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSecondView" {
            let secondVC = segue.destination as! SecondScreenViewController
            secondVC.userName = user!.nome
            secondVC.cpf = customCPF.cpfFormatter(cpfString: user?.cpf ?? "")
            secondVC.balance = user?.saldo
            secondVC.token = user?.token
        }
    }
    
//    func showPopUpAlert () {
//        circle.colors(color1: UIColor.blue, color2: UIColor.lightGray, color3: UIColor.systemBlue)
//        image.addSubview(circle)
//        circle.start()
//
//        let alert = UIAlertController(title: "Loading", message: "", preferredStyle: .alert)
//        alert.view?.addSubview(image)
//        present(alert, animated: true)
//    }
    
}

