//
//  FinanceBrain.swift
//  BuyOrRent
//
//  Created by eric yu on 4/8/18.
//  Copyright © 2018 eric yu. All rights reserved.
//

//MVC- Model

import Foundation

class FinanceBrain {
    
    
    func totalRentFor(baseRent rent:Int, increasePercentage rate: Double,years x: Int)->Double{
        
        var sum: Double = 0
        for i in 1...x {
          sum = sum + Double(rent) * 12.0 * rentIn(years: i, rate: rate)
        }
        return sum
    }
    
    func getAnnualMorgageSum(montly x: Double)-> Double{
        return x * 12.0
    }
    
    func monthlyMortgage(numberOfYears x: Int, rate y: Double, principal z: Double, year w: Int)-> Double  {
        return monthlyMortgage(numberOfMonth: x * 12, rate: y,principal: z, year: w)
    }
    
    
    func monthlyMortgage(numberOfMonth x: Int, rate y: Double, principal z: Double, year w: Int)-> Double  {
        //montly = principal * r (1+r)^ months /[(1+r)^month - 1]
        //r = rate /12
        
        let r = y / 12.0
        let exp = pow(1+r,Double(x))
        
        return z * r * exp / (exp - 1 ) * Double(w) * 12.0
    }
    
    
    
    
  
}


//MARK: private functions
extension FinanceBrain {
    private func rentIn(years x: Int, rate y: Double) -> Double {
        // example 3%  year 3  (1.03)^3
        let rentInYearX = pow((1.0 + y/100),Double(x-1))
        return rentInYearX
    }
    
}
