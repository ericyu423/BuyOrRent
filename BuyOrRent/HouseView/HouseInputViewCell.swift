//
//  HouseInputTableViewCell.swift
//  BuyOrRent
//
//  Created by eric yu on 4/8/18.
//  Copyright © 2018 eric yu. All rights reserved.
//

import UIKit

class HouseInputViewCell: UITableViewCell {
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var textfield1: UITextField!
    @IBOutlet weak var textfield2: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setLabels(currentLabel:String){
       self.label.text = currentLabel
    }

}
