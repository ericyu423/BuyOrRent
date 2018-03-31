//
//  ViewController.swift
//  BuyOrRent
//
//  Created by eric yu on 3/30/18.
//  Copyright © 2018 eric yu. All rights reserved.
//

import UIKit
@IBDesignable
class HouseViewController: UIViewController {
    
    @IBOutlet var rentPicker: UIPickerView!
    
    
    @IBOutlet weak var rentTextField: UITextField!
    @IBOutlet weak var priceRangeATextField: UITextField!
    @IBOutlet weak var priceRangeBTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeNavigationBar()
        initializeTextFields()
        
        

    }
    
    private func initializeNavigationBar() {
        navigationItem.title = "House"
    }
    
    private func initializeTextFields(){
        
        rentTextField.inputView = rentPicker
        priceRangeATextField.inputView = rentPicker
        priceRangeBTextField.inputView = rentPicker
 
    }
}
//MARK:- Picker Delegate

extension HouseViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 4
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 4
    }
  
  
}

