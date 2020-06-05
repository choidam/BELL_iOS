//
//  AqiDetailViewController.swift
//  BELL
//
//  Created by 최은지 on 31/05/2020.
//  Copyright © 2020 최은지. All rights reserved.
//

import UIKit

class AqiDetailViewController: UIViewController {

    @IBOutlet weak var imageContainView1: UIView!
    @IBOutlet weak var imageContainView2: UIView!
    @IBOutlet weak var imageContainView3: UIView!
    
    @IBOutlet weak var activeView: UIView!
    @IBOutlet weak var activeLabel: UILabel!
    
    @IBOutlet weak var pm10Label: UILabel! // 미세먼지
    @IBOutlet weak var pm25Label: UILabel! // 초미세먼지
    @IBOutlet weak var ozoneLabel: UILabel! // 오존
    @IBOutlet weak var coLabel: UILabel! // 일산화탄소
    @IBOutlet weak var soLabel: UILabel! // 아황산가스
    @IBOutlet weak var noLabel: UILabel! // 이산화질소
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imageContainView1.setViewShadow()
        self.imageContainView2.setViewShadow()
        self.imageContainView3.setViewShadow()
        
        self.activeView.setViewShadow()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleClickActiveView( _:)))
        self.imageContainView1.addGestureRecognizer(tap)
        self.imageContainView2.addGestureRecognizer(tap)
        self.imageContainView3.addGestureRecognizer(tap)
        
    }
    
    // MARK : ImageContainView 클릭 이벤트
    @objc func handleClickActiveView(_ sender: UITapGestureRecognizer? = nil){
        print("click!")
        print(index)
    }
    
}
