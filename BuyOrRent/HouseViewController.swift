//
//  ViewController.swift
//  BuyOrRent
//
//  Created by eric yu on 3/30/18.
//  Copyright © 2018 eric yu. All rights reserved.
//

import UIKit
@IBDesignable
class HouseViewController: UIViewController{
    
    @IBOutlet weak var rentTextField: UITextField!
    @IBOutlet weak var priceRangeATextField: UITextField!
    @IBOutlet weak var priceRangeBTextField: UITextField!
    
    @IBOutlet weak var annualRentRaise: UITextField!
    @IBOutlet weak var annualMortgageRate: UITextField!

    let interestArray = Array(0...10) //interest rate %
    let mortgageArray = Array(0...99)
    

    
    @IBOutlet var pickerView: UIPickerView!
    
    var currentRent: Int = 0 {
        didSet {
          print("value change recalculate")
        }
    }
    
    var range1: Int = 0 {
        didSet {
            print("range1 change recalculate")
        }
    }
    var range2: Int = 0 {
        didSet {
            print("range2 change recalculate")
        }
    }

    @IBAction func rentTextFieldClicked(_ sender: UITextField) {
        currentRent = covertSenderTextToInt(sender: sender)
    }
    @IBAction func priceRangeOneClicked(_ sender: UITextField) {
        
        range1 = covertSenderTextToInt(sender: sender)
        
    }
    @IBAction func priceRnageTwoClicked(_ sender: UITextField) {
        range2 = covertSenderTextToInt(sender: sender)
    }
    @IBAction func rentIncreasePerYear(_ sender: UIButton) {
        pickerView.isHidden = false
    }
    
    private func covertSenderTextToInt(sender: UITextField)-> Int{
        guard let senderText = sender.text else {return 0}
        guard let senderTextInInt = Int(senderText) else {return 0}
        return senderTextInInt
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Rent Vs Buy"
        priceRangeATextField.delegate = self
        priceRangeBTextField.delegate = self
        
        pickerView.delegate = self
        pickerView.dataSource = self
        annualRentRaise.delegate = self
        annualMortgageRate.delegate = self
        
        pickerView.backgroundColor = .lightGray
        
        annualRentRaise.inputView = pickerView
        annualMortgageRate.inputView = pickerView
        annualRentRaise.tintColor = .clear //disable blinker
    }
 
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
         annualRentRaise.resignFirstResponder()
         annualMortgageRate.resignFirstResponder()
    }
}

//MARK:- Picker Delegate

extension HouseViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (annualRentRaise.isFirstResponder) {
            return interestArray.count
        }else {
            return mortgageArray.count
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if (annualRentRaise.isFirstResponder) {
            annualRentRaise.text = displayInterestFrom(row: row)
        }else if (annualMortgageRate.isFirstResponder){
            annualMortgageRate.text = displayMortageFrom(row:  row)
        }
    }
    
   
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if (annualRentRaise.isFirstResponder) {
            return displayInterestFrom(row: row)
        }
        
            return displayMortageFrom(row:  row)
       
        
    
    }
    
    private func displayInterestFrom(row: Int) -> String {
            return String(interestArray[row]) + "%"
    
    }
    private func displayMortageFrom(row: Int) -> String {
        let mortageRate: Double = Double(mortgageArray[row])/10.0
        
            return String(format: "%.1f",mortageRate) + "%"
    }
    

}

//MARK- TextView Delegate
extension HouseViewController:UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
           pickerView.reloadAllComponents()
           let row = getCurrentRate(textField: textField)
           pickerView.selectRow(row, inComponent: 0, animated: true)
    }
    
    private func getCurrentRate(textField: UITextField) -> Int{
        
        guard var currentRate = textField.text else {
            return 0
        }
        
        currentRate = currentRate.replacingOccurrences(of: "[^1234567890]", with: "" ,options: [.regularExpression])
        
        guard let currentRateInt = Int(currentRate) else {
            return 0
        }
        return currentRateInt
        
       
        
    }
    
    
}


