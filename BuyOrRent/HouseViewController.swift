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
    
    let interestArray = Array(0...10) //interest rate %

    
    lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.backgroundColor = UIColor.lightGray
        return pickerView
    }()
    
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
        initializeNavigationBar()
        initializedTextView()
        
     
 
    }
    
   
    private func initializeNavigationBar() {
        navigationItem.title = "Rent Vs Buy"
    }
    
    private func initializedTextView(){
        rentTextField.delegate = self
        priceRangeATextField.delegate = self
        priceRangeBTextField.delegate = self
    }
    

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        rentTextField.resignFirstResponder()
        priceRangeATextField.resignFirstResponder()
        priceRangeBTextField.resignFirstResponder()
    }
}

//MARK:- Picker Delegate

extension HouseViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        
        return interestArray.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
        
    }
    
   
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return displayInterestFrom(row: row)
    }
    
    private func displayInterestFrom(row: Int) -> String {
            return String(interestArray[row]) + "%"
    
    }
    
    

}

//MARK- TextView Delegate
extension HouseViewController:UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    
}


