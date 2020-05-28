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
    
    @IBOutlet weak var graphView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.aqiView.setViewShadow()
        self.graphView.setViewShadow()

    }

}
