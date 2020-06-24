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
        
        self.view.setSplashGradientBackground(colorTop: UIColor(rgb: 0xFC5763), colorBottom: UIColor(rgb: 0xFD9367))
        
        self.animateBellImage()
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            self.animateBellImage()
        })
        
        perform(#selector(goMain), with: nil, afterDelay: 2.0)
    }
    
    // MARK : Main 화면으로 넘어가기
    @objc func goMain(){
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        vc.modalPresentationStyle = .overCurrentContext
        
        self.present(vc, animated: true, completion: nil)
    }
    
    // MARK : bell image animation
    func animateBellImage(){
        self.bellUIImage.transform = CGAffineTransform(rotationAngle: -0.1)
        UIView.animate(
            withDuration: 1.2,
            delay: 0,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 0.2,
            options: .curveEaseOut,
            animations: {
                self.bellUIImage.transform = CGAffineTransform(rotationAngle: 0.1)
        }, completion: nil)
    }

}
