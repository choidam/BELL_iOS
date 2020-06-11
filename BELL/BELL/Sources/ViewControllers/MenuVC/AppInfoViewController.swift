//
//  AppInfoViewController.swift
//  BELL
//
//  Created by 최은지 on 11/06/2020.
//  Copyright © 2020 최은지. All rights reserved.
//

import UIKit

class AppInfoViewController: UIViewController {
    
    
    @IBOutlet weak var openButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.openButton.layer.borderColor = UIColor.gray.cgColor
        self.openButton.layer.borderWidth = 1
        self.openButton.layer.cornerRadius = 5
        
    }

}
