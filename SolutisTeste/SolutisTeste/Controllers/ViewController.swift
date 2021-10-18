//
//  ViewController.swift
//  SolutisTeste
//
//  Created by marcelo frost marchesan on 20/09/21.
//

import UIKit

class HomeScreenViewController: UIViewController {

    var secondVC = SecondScreenViewController()
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    @IBAction func loginPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "showSecondView", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
}

