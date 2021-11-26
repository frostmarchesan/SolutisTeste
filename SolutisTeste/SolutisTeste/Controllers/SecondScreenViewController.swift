//
//  SecondScreenViewController.swift
//  SolutisTeste
//
//  Created by Virtual Machine on 18/10/21.
//

import UIKit
import CircleLoadingViewPod

class SecondScreenViewController: UIViewController {

    var customModel = CustomNames()
    var statements : [Statement] = []
    var statementRequest = ServiceRequest()
    var amountRequest = CustomNumberModel()
    var userName: String?
    var cpf: String?
    var balance: Double?
    var token: String?
    let circle1 = CircleLines()
    let circle2 = CircleLines()
    let circle3 = CircleLines()

    @IBOutlet weak var usernameOutletLabel: UILabel!
    @IBOutlet weak var cpfOutletLabel: UILabel!
    @IBOutlet weak var balanceOutletLabel: UILabel!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var statementTableView: UITableView!
    @IBOutlet weak var circleViewOutlet: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statementTableView.dataSource = self
        statementTableView.register(UINib(nibName: "ReusableCellTableViewCell", bundle: nil), forCellReuseIdentifier: "ReusableCellTableViewCell")
        bgView.layer.insertSublayer(createGradient(), at: 0)
        populateLabels(username: userName ?? "", cpf: cpf ?? "", balance: balance ?? 0.0)
        showCircleLoading()
        statementRequest.performStatementRequest(urlString: "https://api.mobile.test.solutis.xyz/extrato", userToken: token ?? "") { result in
            switch result{
            case .success(let statementResult):
                DispatchQueue.main.async {
                    self.dismissCircleLoading()
                    self.statements = statementResult
                    self.statementTableView.reloadData()
                }
            case .failure(let error):
                self.dismissCircleLoading()
                print(error)
            }
        }
    }
    
    @IBAction func logoffPressed(_ sender: UIButton) {
        logoffAlertController()
    }
    
    func populateLabels (username: String, cpf: String, balance: Double) {
        usernameOutletLabel.text = username
        cpfOutletLabel.text = cpf
        balanceOutletLabel.text = "R$ \(amountRequest.currencyConverter(amount: balance))"
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCellTableViewCell", for: indexPath) as! ReusableCellTableViewCell
        cell.operationLabel.text = customModel.customOperationLabels(amount: statements[indexPath.row].valor)
        cell.dateLabel.text = customModel.customDateLabels(date: statements[indexPath.row].data)
        cell.descriptionLabel.text = statements[indexPath.row].descricao
        cell.amountLabel.textColor = customModel.customAmountColor(amount: statements[indexPath.row].valor)
        cell.amountLabel.text = customModel.customAmountLabel(amount: statements[indexPath.row].valor)
        return cell
    }
    
    
    
        
    func showCircleLoading () {
        if (circleViewOutlet.isHidden) {
            configureCircles()
            circleViewOutlet.isHidden = false
            
//            circleViewOutlet.colors(color1: UIColor.blue, color2: UIColor.lightGray, color3: UIColor.systemBlue)
//            circleViewOutlet.start()
        }
    }
    
    func dismissCircleLoading () {
        circleViewOutlet.isHidden = true
        circle1.stopAnimation()
        circle2.stopAnimation()
        circle3.stopAnimation()
        circle1.removeFromSuperview()
        circle2.removeFromSuperview()
        circle3.removeFromSuperview()
//        circleViewOutlet.stop()
    }
    
    func logoffAlertController () {
        let alert = UIAlertController(title: "", message: "Deseja mesmo sair?", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Cancelar", style: UIAlertAction.Style.default, handler: nil))
        alert.addAction(UIAlertAction(title: "Sair", style: UIAlertAction.Style.destructive, handler: { action in
            self.performSegue(withIdentifier: "logoffSegue", sender: self)}))
        present(alert, animated: true, completion: nil)
    }
    
    func configureCircles() {
        circleViewOutlet.addSubview(
            circle1.configureCircle(view: circleViewOutlet, position: 60, width: 120, height: 120, color: UIColor.blue.cgColor, lineWidth: 6, strokeStart: 0.3, strokeEnd: 0.7, speed: 1))
        
        circleViewOutlet.addSubview(
            circle2.configureCircle(view: circleViewOutlet, position: 50, width: 100, height: 100, color: UIColor.gray.cgColor, lineWidth: 6, strokeStart: 0.1, strokeEnd: 0.5, speed: 1.2))
        
        circleViewOutlet.addSubview(
            circle3.configureCircle(view: circleViewOutlet, position: 40, width: 80, height: 80, color: UIColor.systemBlue.cgColor, lineWidth: 6, strokeStart: 0.5, strokeEnd: 0.8, speed: 1.5))
        
    }
    
}
