//
//  AqiViewController.swift
//  BELL
//
//  Created by 최은지 on 27/05/2020.
//  Copyright © 2020 최은지. All rights reserved.
//

import UIKit

class AqiViewController: UIViewController {

    
    @IBOutlet weak var aqiView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        // setting navigation bar
        self.navigationController?.view.backgroundColor = UIColor.mainColor
        
        // setting aqiview shadow
        self.aqiView.setViewShadow()
        
        
        
    }
    

    

}
