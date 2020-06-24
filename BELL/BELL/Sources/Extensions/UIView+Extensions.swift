//
//  UIView+Extensions.swift
//  BELL
//
//  Created by 최은지 on 27/05/2020.
//  Copyright © 2020 최은지. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func setViewShadow(){
        self.layer.cornerRadius = 7
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.15
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 2
    }
    
    func deselectImageView(){
        self.layer.cornerRadius = 7
        self.layer.borderColor = UIColor(rgb: 0xdcdcdc).cgColor
        self.layer.borderWidth = 1
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.15
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 2
    }
    
    func selectImageView(){
        self.layer.cornerRadius = 7
        self.layer.borderColor = UIColor(rgb: 0x9696FF).cgColor
        self.layer.borderWidth = 1
    }
    
    func setGradientBackground(colorTop: UIColor, colorBottom: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorBottom.cgColor, colorTop.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.locations = [0, 1]
        gradientLayer.cornerRadius = 7
        gradientLayer.frame = bounds
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func setSplashGradientBackground(colorTop: UIColor, colorBottom: UIColor){
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop.cgColor, colorBottom.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.locations = [NSNumber(floatLiteral: 0.0), NSNumber(floatLiteral: 1.0)]
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
}
