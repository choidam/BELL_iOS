//
//  PopupViewController.swift
//  BELL
//
//  Created by 최은지 on 07/06/2020.
//  Copyright © 2020 최은지. All rights reserved.
//

import UIKit

class PopupViewController: UIViewController {

    var pm10:String = ""
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var emojiView: UIView!
    
//    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet weak var aqiSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("@@@@@popup", self.pm10)
        
        self.popUpView.setViewShadow()
        self.emojiView.layer.cornerRadius = 50
        
        guard let  aqiIdxToFloat = Float(self.pm10) else { return }
        self.aqiSlider.value = aqiIdxToFloat
        self.aqiSlider.isUserInteractionEnabled = false
        self.aqiSlider.te
        self.aqiSlider.center = setUISliderThumbValueWithLabel(slider: self.aqiSlider)
        
//        self.setUISliderThumbValueWithLabel(slider: self.aqiSlider)
        
        
    }
    
    @IBAction func clickDismiss(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setUISliderThumbValueWithLabel(slider: UISlider) -> CGPoint {
        let slidertTrack : CGRect = slider.trackRect(forBounds: slider.bounds)
        let sliderFrm : CGRect = slider .thumbRect(forBounds: slider.bounds, trackRect: slidertTrack, value: slider.value)
        return CGPoint(x: sliderFrm.origin.x + slider.frame.origin.x + 8, y: slider.frame.origin.y + 20)
    }
    
}
