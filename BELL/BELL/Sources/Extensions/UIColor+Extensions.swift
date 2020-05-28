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
    
    
    @nonobjc class var mainColor: UIColor {
        // color literal
        return #colorLiteral(red: 0.5836365819, green: 0.5580925941, blue: 1, alpha: 1)
    }
    
}
