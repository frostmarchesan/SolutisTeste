//
//  reusableCellTableViewCell.swift
//  SolutisTeste
//
//  Created by Virtual Machine on 18/10/21.
//

import UIKit

class reusableCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var operationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var backgroundCellView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
