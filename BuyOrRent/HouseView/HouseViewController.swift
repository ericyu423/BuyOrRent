//
//  ViewController.swift
//  BuyOrRent
//
//  Created by eric yu on 3/30/18.
//  Copyright © 2018 eric yu. All rights reserved.
//

import UIKit

let LAST_RENT_VALUE = "lastRentValue"
let LAST_RANGE_1_VALUE = "lastRange1Value"
let LAST_RANGE_2_VALUE = "lastRange2Value"
let RENT_INCREASE_RATE = "rentIncreaseRate"
let MORTGAGE_RATE = "mortgageRate"


class HouseViewController: UIViewController{
    
   
    let maxYear = 30
    let financeBrain = FinanceBrain()
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var inputTableView: UITableView!
    
    
    @IBOutlet weak var rentTextField: UITextField!
    @IBOutlet weak var priceRangeATextField: UITextField!
    @IBOutlet weak var priceRangeBTextField: UITextField!
    
    @IBOutlet weak var annualRentRaise: UITextField!
    @IBOutlet weak var annualMortgageRate: UITextField!

    let interestArray = Array(0...10) //interest rate %
    let mortgageArray = Array(0...99)
    
    let textFieldTableArray = ["tax","hoa","insurance","maintenance","eletricity","water" ]
    
    @IBOutlet var pickerView: UIPickerView!
    
   
    var annualRentRiseValue: Double = 3 {
        didSet {
            tableView.reloadData()
        }
    }
    
    //40 = 4%
    var annualMortgageRateValue: Double = 40 {
        didSet {
            tableView.reloadData()
        }
    }
    
    var currentRent: Int = 1000 {
        didSet {
            tableView.reloadData()
        }
    }
    
    var range1: Int = 250000 {
        didSet {
            tableView.reloadData()
        }
    }
    var range2: Int = 550000 {
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
  
        
        loadLastSavedInput()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
       
        self.tabBarController?.tabBar.layer.zPosition = -1
        
    }
    
    private func loadLastSavedInput(){
        
        
        //default
       
        
        //TODO: use NSDefault or CoreData
        //load default if any else set default
        if let rent = UserDefaults.standard.object(forKey: LAST_RENT_VALUE){
            currentRent = rent as? Int ?? 0
        }
        if let rangeA = UserDefaults.standard.object(forKey: LAST_RANGE_1_VALUE) {
            range1 = rangeA as? Int ?? 0
        }
       if let rangeB = UserDefaults.standard.object(forKey: LAST_RANGE_2_VALUE)
       {
            range2 = rangeB as? Int ?? 0
        }
        
        if let rentRate = UserDefaults.standard.object(forKey: RENT_INCREASE_RATE)
        {
            annualRentRiseValue = rentRate as? Double ?? 0.0
        }
        
        if let mortgageRate = UserDefaults.standard.object(forKey: MORTGAGE_RATE)
        {
            annualMortgageRateValue = mortgageRate as? Double ?? 0.0
        }
        
        
        rentTextField.placeholder = "\(currentRent)"
        priceRangeATextField.placeholder = "\(range1)"
        priceRangeBTextField.placeholder = "\(range2)"
   
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
            annualMortgageRateValue = Double(interestArray[row])
           
        }else if (annualMortgageRate.isFirstResponder){
            annualMortgageRate.text = displayMortageFrom(row:  row)
            annualMortgageRateValue = Double(mortgageArray [row])
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
        
        switch tableView {
           
        case self.tableView:
            
            return maxYear//
            
        case self.inputTableView:
            
            return textFieldTableArray.count
        default:
            return 0 //error
        }

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch tableView {
            
        case self.tableView:
            
             return cellForTableView(cellForRowAt: indexPath)
        case self.inputTableView:
            
            return cellForInputTableView(cellForRowAt: indexPath)
        default:
            return UITableViewCell() //error
            
        }
 
    }
    private func cellForInputTableView(cellForRowAt indexPath: IndexPath)-> HouseInputViewCell{
        
        
          let cell = inputTableView.dequeueReusableCell(withIdentifier: "InputCell", for: indexPath) as! HouseInputViewCell
        
        cell.setLabels(currentLabel: textFieldTableArray[indexPath.row])
        
        return cell
        
    }
    
    private func cellForTableView(cellForRowAt indexPath: IndexPath)-> HouseTableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! HouseTableViewCell
        
        let currentRentAccumlation = financeBrain.totalRentFor(baseRent: currentRent, increasePercentage: annualRentRiseValue, years: indexPath.row+1)
        
        let mortgage1Accumation = financeBrain.monthlyMortgage(numberOfYears: 30, rate: annualMortgageRateValue/1000, principal: Double(range1),year: (indexPath.row + 1))
        
        let mortgage2Accumation = financeBrain.monthlyMortgage(numberOfYears: 30, rate:annualMortgageRateValue/1000, principal: Double(range2),year: (indexPath.row + 1))
        
        cell.setLabels(year: "year \(indexPath.row + 1)", rent: "\(Int(currentRentAccumlation))", mortgage1: "\(Int(mortgage1Accumation))", mortgage2: "\(Int(mortgage2Accumation))")
        
        return cell
    }
}


