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
    var validator = LoginValidator()
    var secondVC = SecondScreenViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        invalidDataLabel.text = ""
    }

    
    @IBAction func loginPressed(_ sender: UIButton) {
        
        
        if (validator.checkEmail(email: loginTextField.text ?? "")) {
            performSegue(withIdentifier: "showSecondView", sender: self)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
 
    
    
}

