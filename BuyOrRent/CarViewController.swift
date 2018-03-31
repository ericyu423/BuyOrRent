//
//  CarViewController.swift
//  BuyOrRent
//
//  Created by eric yu on 3/30/18.
//  Copyright © 2018 eric yu. All rights reserved.
//

import UIKit

class CarViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initializeNavigationBar()
    }

    private func initializeNavigationBar(){
        navigationController?.title = "Car"
    }
  

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
