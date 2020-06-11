//
//  MenuViewController.swift
//  BELL
//
//  Created by 최은지 on 09/06/2020.
//  Copyright © 2020 최은지. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loginButton.layer.borderWidth = 1
        self.loginButton.layer.borderColor = UIColor.gray.cgColor
        self.loginButton.layer.cornerRadius = 12

    }
    
    // MARK : 공지사항
    @IBAction func goNotice(_ sender: UIButton) {
        
    }
    
    // MARK : 앱 정보
    @IBAction func goAppInfo(_ sender: UIButton) {
        
    }
    
    // MARK : 고객 지원
    @IBAction func goCustomer(_ sender: UIButton) {
        
    }
    
    // MARK : 이용 의견
    @IBAction func goOpinion(_ sender: UIButton) {
        
    }
    

}
