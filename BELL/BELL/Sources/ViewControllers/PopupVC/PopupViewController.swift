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
    @IBOutlet weak var emojiImage: UIImageView!
    @IBOutlet weak var aqiSlider: UISlider!
    
    @IBOutlet weak var aqiSmallLabel: UILabel!
    @IBOutlet weak var aqiBigLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.popUpView.setViewShadow()
        self.emojiView.layer.cornerRadius = 50
        
        self.pm10Setting()
        self.aqiSlider.isUserInteractionEnabled = false
    }
    
    // MARK : 창 닫기
    @IBAction func clickDismiss(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK : UISlider animate
    func setSliderAnimate(){
        guard let aqiIdxToFloat = Float(self.pm10) else { return }
        
        UIView.animate( withDuration: 0.1, animations: {
            self.aqiSlider.setValue(0, animated:true)
        }, completion: { _ in
            UIView.animate(withDuration: 2.0, animations: {
                self.aqiSlider.setValue(aqiIdxToFloat, animated: true)
            })
        })
    }
    
    // MARK : 미세먼지 수치에 따른 UI Setting (pm10)
    func pm10Setting(){
        self.setSliderAnimate()
        self.aqiSmallLabel.text = "현재 수치 : " + self.pm10 + " ㎍/㎥"
        guard let pm10ToInt = Int(self.pm10) else { return }
        
        switch pm10ToInt {
        case let x where x <= 30:
            self.aqiSlider.tintColor = UIColor.grade1
            self.emojiImage.image = UIImage(named: "emoji1")
            self.aqiBigLabel.text = "미세먼지 좋음"
            self.aqiBigLabel.textColor = UIColor.grade1
        case let x where x <= 80 :
            self.aqiSlider.tintColor = UIColor.grade2
            self.emojiImage.image = UIImage(named: "emoji2")
            self.aqiBigLabel.text = "미세먼지 보통"
            self.aqiBigLabel.textColor = UIColor.grade2
        case let x where x <= 150 :
            self.aqiSlider.tintColor = UIColor.grade3
            self.emojiImage.image = UIImage(named: "emoji4")
            self.aqiBigLabel.text = "미세먼지 나쁨"
            self.aqiBigLabel.textColor = UIColor.grade3
        default:
            self.aqiSlider.tintColor = UIColor.grade4
            self.emojiImage.image = UIImage(named: "emoji6")
            self.aqiBigLabel.text = "미세먼지 매우 나쁨"
            self.aqiBigLabel.textColor = UIColor.grade4
        }
    }
 
}
