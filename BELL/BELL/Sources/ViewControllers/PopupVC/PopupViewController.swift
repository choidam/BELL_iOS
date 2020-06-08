//
//  PopupViewController.swift
//  BELL
//
//  Created by 최은지 on 07/06/2020.
//  Copyright © 2020 최은지. All rights reserved.
//

import UIKit

class PopupViewController: UIViewController {
    
    var pm10: String = "" // 미세먼지 수치
    var pm25: String = "" // 초 미세먼지 수치
    
    var isPm10: Bool = true // 미세 버튼 클릭 여부
    
    @IBOutlet weak var popUpView: UIView!
    
    @IBOutlet weak var emojiView: UIView!
    @IBOutlet weak var emojiImage: UIImageView!
    @IBOutlet weak var aqiSlider: UISlider!
    
    @IBOutlet weak var aqiSmallLabel: UILabel!
    @IBOutlet weak var aqiBigLabel: UILabel!
    
    @IBOutlet weak var midSliderLabel: UILabel!
    @IBOutlet weak var endSliderLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.popUpView.setViewShadow()
        self.emojiView.layer.cornerRadius = 50
        self.aqiSlider.isUserInteractionEnabled = false
        
        if self.isPm10 == true {
            self.pm10Setting()
        } else {
            self.pm25Setting()
        }
    }
    
    // MARK : 창 닫기
    @IBAction func clickDismiss(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK : UISlider animate - pm10
    func setSliderAnimate(){
        self.aqiSlider.minimumValue = 0.0
        self.aqiSlider.maximumValue = 200.0
        self.midSliderLabel.text = "100"
        self.endSliderLabel.text = "200"
        
        guard let aqiIdxToFloat = Float(self.pm10) else { return }
        
        UIView.animate( withDuration: 0.1, animations: {
            self.aqiSlider.setValue(0, animated:true)
        }, completion: { _ in
            UIView.animate(withDuration: 2.0, animations: {
                self.aqiSlider.setValue(aqiIdxToFloat, animated: true)
            })
        })
    }
    
    // MARK : UISlider animate - pm10
    func setSliderAnimate2(){
        self.aqiSlider.minimumValue = 0.0
        self.aqiSlider.maximumValue = 100.0
        self.midSliderLabel.text = "50"
        self.endSliderLabel.text = "100"
        
        guard let aqiIdxToFloat = Float(self.pm25) else { return }
        
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
    
    // MARK : 초미세먼지 수치에 따른 view,label 설정 (pm25)
    func pm25Setting(){
        self.setSliderAnimate2()
        guard let pm25ToInt = Int(self.pm25) else { return }
        self.aqiSmallLabel.text = "현재 수치 : " + self.pm25 + " ㎍/㎥"
    
        switch pm25ToInt {
        case let x where x <= 15:
            self.aqiSlider.tintColor = UIColor.grade1
            self.emojiImage.image = UIImage(named: "emoji1")
            self.aqiBigLabel.text = "초미세먼지 좋음"
            self.aqiBigLabel.textColor = UIColor.grade1
        case let x where x <= 35 :
            self.aqiSlider.tintColor = UIColor.grade2
            self.emojiImage.image = UIImage(named: "emoji2")
            self.aqiBigLabel.text = "초미세먼지 보통"
            self.aqiBigLabel.textColor = UIColor.grade2
        case let x where x <= 75 :
            self.aqiSlider.tintColor = UIColor.grade3
            self.emojiImage.image = UIImage(named: "emoji4")
            self.aqiBigLabel.text = "초미세먼지 나쁨"
            self.aqiBigLabel.textColor = UIColor.grade3
        default:
            self.aqiSlider.tintColor = UIColor.grade4
            self.emojiImage.image = UIImage(named: "emoji6")
            self.aqiBigLabel.text = "초미세먼지 매우 나쁨"
            self.aqiBigLabel.textColor = UIColor.grade4
        }
    }
 
}
