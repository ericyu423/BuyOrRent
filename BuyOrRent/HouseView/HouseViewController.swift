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
    
    let maxYear = 30
    let financeBrain = FinanceBrain()
    
    @IBOutlet weak var tableView: UITableView!
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
            tableView.reloadData()
        }
    }
    
    var range1: Int = 0 {
        didSet {
            tableView.reloadData()
        }
    }
    var range2: Int = 0 {
        didSet {
            tableView.reloadData()
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

extension HouseViewController: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return maxYear
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HouseTableViewCell
        

        
        guard var annualRentRaiseString = annualRentRaise.text else {return cell}
        annualRentRaiseString = annualRentRaiseString.replacingOccurrences(of: "%", with: "")
        guard let annualRentRaiseDouble: Double = Double(annualRentRaiseString) else {return cell }
        
      
        let currentRentAccumlation = financeBrain.totalRentFor(baseRent: currentRent, increasePercentage: annualRentRaiseDouble, years: indexPath.row+1)
        
        cell.setLabels(year: "year \(indexPath.row + 1)", rent: "\(Int(currentRentAccumlation))", mortgage1: "", mortgage2: "")
       
        return cell
    }
}

