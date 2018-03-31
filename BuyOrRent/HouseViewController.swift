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
    
    @IBOutlet var rentPicker: UIPickerView!
    @IBOutlet weak var rentTextField: UITextField!
    @IBOutlet weak var priceRangeATextField: UITextField!
    @IBOutlet weak var priceRangeBTextField: UITextField!
    
    var currentRent = 0;
    
    enum CurrentTextField {
        case priceRangeA
        case priceRangeB
        case rent
    }
    
    let rent = [
                 [0,1,2,3,4,5,6,7,8,9],
                 [0,1,2,3,4,5,6,7,8,9],
                 [0,1,2,3,4,5,6,7,8,9],
                 [0,1,2,3,4,5,6,7,8,9],
               ]
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeNavigationBar()
        initializeTextFields()
        initializedTextView()
        initializeUIPicker()

    }
    
    private func initializeUIPicker(){
        rentPicker.delegate = self
        rentPicker.dataSource = self
    }
    
    private func initializeNavigationBar() {
        navigationItem.title = "House"
    }
    
    private func initializedTextView(){
        rentTextField.delegate = self
        priceRangeATextField.delegate = self
        priceRangeBTextField.delegate = self
    }
    
    private func initializeTextFields(){
        rentTextField.inputView = rentPicker
        priceRangeATextField.inputView = rentPicker
        priceRangeBTextField.inputView = rentPicker
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        rentTextField.resignFirstResponder()
        priceRangeATextField.resignFirstResponder()
        priceRangeBTextField.resignFirstResponder()
        
        
    }
}

//MARK- TextView Delegate
extension HouseViewController:UITextFieldDelegate {
    
    
    
    
}


//MARK:- Picker Delegate

extension HouseViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
     
        return rent.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        
        return rent[component].count
    }
    
   
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        rentTextField.text = String(returnRentValue(baseOn: pickerView))
        
    }
    
    private func returnRentValue(baseOn pickerView: UIPickerView) -> Int{
        
        return pickerView.selectedRow(inComponent: 0) * 1000 + pickerView.selectedRow(inComponent: 1) * 100 + pickerView.selectedRow(inComponent: 2) * 10 + pickerView.selectedRow(inComponent: 3) * 1
        
    }
    

    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return String(rent[component][row])
    }
  
  
}

