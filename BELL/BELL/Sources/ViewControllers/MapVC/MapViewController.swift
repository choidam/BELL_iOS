//
//  MapViewController.swift
//  BELL
//
//  Created by 최은지 on 27/05/2020.
//  Copyright © 2020 최은지. All rights reserved.
//

import UIKit
import FloatingPanel

class MapViewController: UIViewController, FloatingPanelControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fpc = FloatingPanelController()
        fpc.delegate = self
        
        guard let contentVC = storyboard?.instantiateViewController(identifier: "fpc_content") as? MapContentViewController else { return }
        
        fpc.set(contentViewController: contentVC)
        fpc.addPanel(toParent: self)

        // fpc_content
        
        
    }


}
