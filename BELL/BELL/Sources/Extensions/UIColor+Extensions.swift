//
//  Color+Extensions.swift
//  BELL
//
//  Created by 최은지 on 04/05/2020.
//  Copyright © 2020 최은지. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    // allows hexadecimal color ie: UIColor(rgb: 0xFD9367).
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
    
    @nonobjc class var lightGray: UIColor {
        return UIColor(rgb: 0xF7F6F5)
    }
    
    @nonobjc class var darkGray: UIColor {
        return UIColor(rgb: 0x393C41)
    }
    
    @nonobjc class var skyblue: UIColor {
        return UIColor(rgb: 0xf0f5f9)
    }
    
    // MARK : grade1~grade4 미세먼지 등급에 따른 색상 - 좋음, 보통, 나쁨, 매우 나쁨
    @nonobjc class var grade1: UIColor {
        return UIColor(rgb: 0x3232FF)
    }
    
    @nonobjc class var grade2: UIColor {
        return UIColor(rgb: 0xFFC300)
    }
    
    @nonobjc class var grade3: UIColor {
        return UIColor(rgb: 0xFFE146)
    }
    
    @nonobjc class var grade4: UIColor {
        return UIColor(rgb: 0xFF4646)
    }

}
