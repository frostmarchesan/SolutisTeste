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
        
        loginTextField.textColor = .systemGray
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
        
        var loginCheck : Bool = validator.checkUserLog(entry: loginTextField.text ?? "")
        var passwordCheck : Bool = validator.checkPassword(password: passwordTextField.text ?? "")
        
        if (loginCheck && passwordCheck) {
            showCircleLoading()

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
                        self.dismissCircleLoading()
                        self.user = userResult
                        self.performSegue(withIdentifier: "showSecondView", sender: self)
                    }
                case .failure(let error):
                    self.dismissCircleLoading()
                    print(error)
                }
            }
        } else {
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
        circleLoading.isHidden = true
        circleLoading.stop()
    }
    
    func alertController () {
        let alert = UIAlertController(title: "", message: "E-mail ou senha incorretos.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}

