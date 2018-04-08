//
//  HouseTableViewCell.swift
//  BuyOrRent
//
//  Created by eric yu on 4/8/18.
//  Copyright © 2018 eric yu. All rights reserved.
//

import UIKit

class HouseTableViewCell: UITableViewCell {
    
    @IBOutlet weak var tableFirstColumnLabel: UILabel!
    @IBOutlet weak var rentTableValue: UILabel!
    @IBOutlet weak var mortgageTableValue1: UILabel!
    @IBOutlet weak var mortgageTableValue2: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    func setLabels(year:String, rent:String, mortgage1: String, mortgage2:String){
        
        tableFirstColumnLabel.text = year
        rentTableValue.text = rent.formatStringNumberToMoneyUS()
        mortgageTableValue1.text = mortgage1.formatStringNumberToMoneyUS()
         mortgageTableValue2.text = mortgage2.formatStringNumberToMoneyUS()
        
    }

}
