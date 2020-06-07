//
//  Popup2ViewController.swift
//  BELL
//
//  Created by 최은지 on 07/06/2020.
//  Copyright © 2020 최은지. All rights reserved.
//

import UIKit

class Popup2ViewController: UIViewController {

    var pm25: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("@@@@@popup", self.pm25)
    }
    
    @IBAction func clickDismiss(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
