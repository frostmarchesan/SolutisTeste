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
        Statement(operation: "", description: "", amount: -98.34)
        ,
        Statement(operation: "", description: "", amount: -98.34)
        ,
        Statement(operation: "", description: "", amount: -98.34)
        ,
        Statement(operation: "", description: "", amount: -98.34)
        ,
        Statement(operation: "", description: "", amount: -98.34),
        Statement(operation: "", description: "", amount: -98.34)
    ]
//    var statements: [Statement] = [
//        Statement(operation: "", date: Date(0), description: "", amount: 123.45),
//        Statement(operation: "", date: Date.now, description: "", amount: 12.34),
//        Statement(operation: "", date: Date.now, description: "", amount: -98.34)
//    ]
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var statementTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statementTableView.dataSource = self
        statementTableView.register(UINib(nibName: "ReusableCellTableViewCell", bundle: nil), forCellReuseIdentifier: "ReusableCellTableViewCell")
        bgView.layer.insertSublayer(createGradient(), at: 0)
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
