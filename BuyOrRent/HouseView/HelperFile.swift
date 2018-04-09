//
//  HelperFile.swift
//  BuyOrRent
//
//  Created by eric yu on 4/8/18.
//  Copyright © 2018 eric yu. All rights reserved.
//

import Foundation

extension String {
    
    func formatStringNumberToMoneyUS()
 -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
     
        
        guard let x = Int(self) else {return self}
        let n = NSNumber(value:x)
        guard let formattedNumber = numberFormatter.string(from: n) else { return self}
  
        return "$" + formattedNumber
    }
    
}
