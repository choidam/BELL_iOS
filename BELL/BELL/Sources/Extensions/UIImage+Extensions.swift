//
//  UIImage+Extensions.swift
//  BELL
//
//  Created by 최은지 on 28/05/2020.
//  Copyright © 2020 최은지. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    // allows creating image from CALayer.
    class func image(from layer: CALayer) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(layer.bounds.size,
                                               layer.isOpaque, UIScreen.main.scale)
        defer { UIGraphicsEndImageContext() }
        // Don't proceed unless we have context
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        layer.render(in: context)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
