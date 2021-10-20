//
//  SecondScreenViewController.swift
//  SolutisTeste
//
//  Created by Virtual Machine on 18/10/21.
//

import UIKit

class SecondScreenViewController: UIViewController {

    var statements: [Statement] = [
        Statement(operation: "", description: "", amount: 123.45),
        Statement(operation: "", description: "", amount: 12.34),
        Statement(operation: "", description: "", amount: -98.34),
        Statement(operation: "", description: "", amount: -98.34),
        Statement(operation: "", description: "", amount: -98.34),
        Statement(operation: "", description: "", amount: -98.34),
        Statement(operation: "", description: "", amount: -98.34),
        Statement(operation: "", description: "", amount: -98.34)
    ]

    var userName: String?
    var cpf: String?
    var balance: Double?
    
    @IBOutlet weak var usernameOutletLabel: UILabel!
    @IBOutlet weak var cpfOutletLabel: UILabel!
    @IBOutlet weak var balanceOutletLabel: UILabel!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var statementTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statementTableView.dataSource = self
        statementTableView.register(UINib(nibName: "ReusableCellTableViewCell", bundle: nil), forCellReuseIdentifier: "ReusableCellTableViewCell")
        bgView.layer.insertSublayer(createGradient(), at: 0)
        print(userName)
        populateLabels(username: userName ?? "", cpf: cpf ?? "", balance: balance ?? 0.0)
        
    }
    
    func populateLabels (username: String, cpf: String, balance: Double) {
        usernameOutletLabel.text = username
        cpfOutletLabel.text = cpf
        let amount = String(format: "%.2f", balance)
        let brazilianAmount = amount.replacingOccurrences(of: ".", with: ",")
        print(brazilianAmount)
        balanceOutletLabel.text = "R$ \(brazilianAmount)"
    }
    
    func createGradient () -> CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.frame = bgView.bounds
        gradient.colors = [UIColor.init(_colorLiteralRed: 175.0/255.0, green: 198.0/255.0, blue: 227.0/255.0, alpha: 1).cgColor   , UIColor.init(_colorLiteralRed: 47.0/255.0, green: 124.0/255.0, blue: 182.0/255.0, alpha: 1).cgColor]
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        return gradient
    }
}

extension SecondScreenViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = statements[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCellTableViewCell", for: indexPath) as! ReusableCellTableViewCell
        return cell

    }
}
