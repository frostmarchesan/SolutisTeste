//
//  reusableCellTableViewCell.swift
//  SolutisTeste
//
//  Created by Virtual Machine on 18/10/21.
//

import UIKit

class ReusableCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var operationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var backgroundCellView: UIView!
    @IBOutlet weak var whiteBackGroundCell: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundCellView.layer.cornerRadius = 20
        operationLabel.textColor = .gray
        dateLabel.textColor = .gray
        descriptionLabel.textColor = .darkGray
        whiteBackGroundCell.layer.cornerRadius = 20
    }
}
