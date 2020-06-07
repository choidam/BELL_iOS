//
//  PopupViewController.swift
//  BELL
//
//  Created by 최은지 on 07/06/2020.
//  Copyright © 2020 최은지. All rights reserved.
//

import UIKit

class PopupViewController: UIViewController {

    var pm10:String = ""
    @IBOutlet weak var popUpView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("@@@@@popup", self.pm10)
        
        self.popUpView.setViewShadow()
    }
    
    @IBAction func clickDismiss(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
