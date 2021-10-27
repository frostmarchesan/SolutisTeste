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
    @IBOutlet weak var circleLoading: CircleLoading!
    @IBOutlet weak var loginButtonOutlet: UIButton!
    @IBOutlet weak var switchButtonOutlet: UISwitch!
    
    var saveUser : Bool = true
    var user : User?
    var validator = LoginValidator()
    var loginRequest = ServiceRequest()
    var customCPF = CustomCPFFormatter()
    let keyChain = KeyChainModel()
    let image = UIImageView()
    let loginUrl = "https://api.mobile.test.solutis.xyz/login"
    let statementURL = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (keyChain.getData(key: "userLogin") != "") {
            loginTextField.text = keyChain.getData(key: "userLogin")
        }
        if (keyChain.getData(key: "userPassword") != "" && keyChain.getData(key: "boolean") == "true") {
            passwordTextField.text = keyChain.getData(key: "userPassword")
        }
        if (keyChain.getData(key: "boolean") == "false"){
            switchButtonOutlet.isOn = false
        }
    }
    
    @IBAction func saveUserLoginSwitch(_ sender: UISwitch) {
        if (sender.isOn) {
            keyChain.storeData(data: "true", key: "boolean")
            saveUser = true
        } else {
            switchButtonOutlet.isOn = false
            keyChain.storeData(data: "false", key: "boolean")
            saveUser = false
        }
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        loginButtonOutlet.isEnabled = false
        var loginCheck : Bool = validator.checkUserLog(entry: loginTextField.text ?? "")
        var passwordCheck : Bool = validator.checkPassword(password: passwordTextField.text ?? "")
        
        if (loginCheck && passwordCheck) {
            showCircleLoading()
            do {
            try loginRequest.performLoginRequest(urlString: loginUrl, userLogin: loginTextField.text ?? "", userPassword: passwordTextField.text ?? "") { result in
                    switch result{
                    case .success(let userResult):
                        DispatchQueue.main.async {
                            if (self.saveUser) {
                                if (self.keyChain.getData(key: "userLogin") == "") {
                                    self.keyChain.storeData(data: self.loginTextField.text ?? "", key: "userLogin")
                                    
                                }
                                if (self.keyChain.getData(key: "userPassword") == "" && self.keyChain.getData(key: "boolean") != "true") {
                                    self.keyChain.storeData(data: self.passwordTextField.text ?? "", key: "userPassword")
                                }
                            } else {
                                self.keyChain.eraseData(key: "userPassword")
                            }
                            self.passwordTextField.text = ""
                            self.dismissCircleLoading()
                            self.user = userResult
                            self.performSegue(withIdentifier: "showSecondView", sender: self)
                        }
                    case .failure(let error):
                        DispatchQueue.main.async {
                            self.dismissCircleLoading()
                            self.loginButtonOutlet.isEnabled = true
                            self.alertController()
                            self.passwordTextField.text = ""
                        }
                    }
                }
            } catch {print("catch")}
        } else {
            loginButtonOutlet.isEnabled = true
            alertController()
            passwordTextField.text = ""
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
    
    func showCircleLoading () {
        if (circleLoading.isHidden) {
            circleLoading.colors(color1: UIColor.blue, color2: UIColor.lightGray, color3: UIColor.systemBlue)
            circleLoading.isHidden = false
            circleLoading.start()
        }
    }
    
    func dismissCircleLoading () {
        DispatchQueue.main.async {
            self.circleLoading.isHidden = true
            self.circleLoading.stop()
        }
        
    }
    
    func alertController () {
        let alert = UIAlertController(title: "", message: "E-mail ou senha incorretos.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}

