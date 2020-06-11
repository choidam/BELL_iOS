//
//  SplashViewController.swift
//  BELL
//
//  Created by 최은지 on 09/06/2020.
//  Copyright © 2020 최은지. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    @IBOutlet weak var bellUIImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        perform(#selector(goMain), with: nil, afterDelay: 2.0)
    }
    
    // MARK : Main 화면으로 넘어가기
    @objc func goMain(){
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        vc.modalPresentationStyle = .overCurrentContext
        
        self.present(vc, animated: true, completion: nil)
    }

}
