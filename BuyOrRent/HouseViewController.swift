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

//MARK- TextView Delegate
extension HouseViewController:UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    
}


