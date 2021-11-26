//
//  ViewController.swift
//  SolutisTeste
//
//  Created by marcelo frost marchesan on 20/09/21.
//

import UIKit
import KeychainSwift
import CircleLoadingViewPod

class HomeScreenViewController: UIViewController {
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var circleLoading: UIView!
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
    let circle1 = CircleLines()
    let circle2 = CircleLines()
    let circle3 = CircleLines()
    
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
        let loginCheck : Bool = validator.checkUserLog(entry: loginTextField.text ?? "")
        let passwordCheck : Bool = validator.checkPassword(password: passwordTextField.text ?? "")
        
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
            
            configureCircles()
            circleLoading.isHidden = false
            
            
//            circleLoading.colors(color1: UIColor.blue, color2: UIColor.lightGray, color3: UIColor.systemBlue)
//            circleLoading.isHidden = false
//            circleLoading.start()
        }
    }
    
    func dismissCircleLoading () {
        DispatchQueue.main.async {
            self.circleLoading.isHidden = true
            self.circle1.stopAnimation()
            self.circle2.stopAnimation()
            self.circle3.stopAnimation()
            self.circle1.removeFromSuperview()
            self.circle2.removeFromSuperview()
            self.circle3.removeFromSuperview()
//              self.circleLoading.stop()
        }
        
    }
    
    func alertController () {
        let alert = UIAlertController(title: "", message: "E-mail ou senha incorretos.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func configureCircles() {
        circleLoading.addSubview(circle1.configureCircle(view: circleLoading, position: 60, width: 120, height: 120, color: UIColor.blue.cgColor, lineWidth: 6, strokeStart: 0.3, strokeEnd: 0.7, speed: 1))
        
        circleLoading.addSubview(circle2.configureCircle(view: circleLoading, position: 50, width: 100, height: 100, color: UIColor.gray.cgColor, lineWidth: 6, strokeStart: 0.1, strokeEnd: 0.5, speed: 1.2))
        
        circleLoading.addSubview(circle3.configureCircle(view: circleLoading, position: 40, width: 80, height: 80, color: UIColor.systemBlue.cgColor, lineWidth: 6, strokeStart: 0.5, strokeEnd: 0.8, speed: 1.5))
    
    }
    
}

