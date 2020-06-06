//
//  AqiDetailViewController.swift
//  BELL
//
//  Created by 최은지 on 31/05/2020.
//  Copyright © 2020 최은지. All rights reserved.
//

import UIKit

class AqiDetailViewController: UIViewController {
    
    var pm10Str: String = ""
    var pm25Str: String = ""
    var ozoneStr: String = ""
    var coStr: String = ""
    var soStr: String = ""
    var noStr: String = ""
    
    @IBOutlet weak var imageContainView1: UIView!
    @IBOutlet weak var imageContainView2: UIView!
    @IBOutlet weak var imageContainView3: UIView!
    
    @IBOutlet weak var activeView: UIView!
    @IBOutlet weak var activeLabel: UILabel!
    
    @IBOutlet weak var pm10Label: UILabel! // 미세먼지
    @IBOutlet weak var pm25Label: UILabel! // 초미세먼지
    @IBOutlet weak var ozoneLabel: UILabel! // 오존
    @IBOutlet weak var coLabel: UILabel! // 일산화탄소
    @IBOutlet weak var soLabel: UILabel! // 아황산가스
    @IBOutlet weak var noLabel: UILabel! // 이산화질소
    
    
    @IBOutlet weak var pm10View: UIView!
    @IBOutlet weak var pm25View: UIView!
    @IBOutlet weak var ozoneView: UIView!
    @IBOutlet weak var coView: UIView!
    @IBOutlet weak var soView: UIView!
    @IBOutlet weak var noView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imageContainView1.setViewShadow()
        self.imageContainView2.setViewShadow()
        self.imageContainView3.setViewShadow()
        
        self.activeView.setViewShadow()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleClickActiveView( _:)))
        self.imageContainView1.addGestureRecognizer(tap)
        self.imageContainView2.addGestureRecognizer(tap)
        self.imageContainView3.addGestureRecognizer(tap)
        
        self.settingLabels()
        
        print("oznoe?? ", self.ozoneStr)
        
    }
    
    // MARK : ImageContainView 클릭 이벤트
    @objc func handleClickActiveView(_ sender: UITapGestureRecognizer? = nil){
        print("click!")
        print(index)
    }
    
    // MARK : 미세먼지 수치에 따른 label & color 지정
    func settingLabels(){
        self.setPm10String()
        self.setPm25String()
        self.setOzoneString()
        self.setCoString()
        self.setSoString()
        self.setNoString()
    }
    
    // MARK : 미세먼지 수치에 따른 view,label 설정 (pm10)
    func setPm10String() -> Void {
        let pm10toInt = Int(self.pm10Str)!
        switch pm10toInt {
        case let x where x <= 30 :
            self.pm10View.layer.backgroundColor = UIColor.grade1.cgColor
            self.pm10Label.text = "좋음 " + self.pm10Str + " ㎍/㎥"
            self.pm10Label.textColor = UIColor.grade1
        case let x where x <= 80 :
            self.pm10View.layer.backgroundColor = UIColor.grade2.cgColor
            self.pm10Label.text = "보통 " + self.pm10Str + " ㎍/㎥"
            self.pm10Label.textColor = UIColor.grade2
        case let x where x <= 150 :
            self.pm10View.layer.backgroundColor = UIColor.grade3.cgColor
            self.pm10Label.text = "나쁨 " + self.pm10Str + " ㎍/㎥"
            self.pm10Label.textColor = UIColor.grade3
        default:
            self.pm10View.layer.backgroundColor = UIColor.grade4.cgColor
            self.pm10Label.text = "매우 나쁨 " + self.pm10Str + " ㎍/㎥"
            self.pm10Label.textColor = UIColor.grade4
        }
    }
    
    // MARK : 초미세먼지 수치에 따른 view,label 설정 (pm25)
    func setPm25String() -> Void {
        let pm20ToInt = Int(self.pm25Str)!
        switch pm20ToInt {
        case let x where x <= 15:
            self.pm25View.layer.backgroundColor = UIColor.grade1.cgColor
            self.pm25Label.text = "좋음 " + self.pm25Str + " ㎍/㎥"
            self.pm25Label.textColor = UIColor.grade1
        case let x where x <= 35 :
            self.pm25View.layer.backgroundColor = UIColor.grade2.cgColor
            self.pm25Label.text = "보통 " + self.pm25Str + " ㎍/㎥"
            self.pm25Label.textColor = UIColor.grade2
        case let x where x <= 75 :
            self.pm25View.layer.backgroundColor = UIColor.grade3.cgColor
            self.pm25Label.text = "나쁨 " + self.pm25Str + " ㎍/㎥"
            self.pm25Label.textColor = UIColor.grade3
        default:
            self.pm25View.layer.backgroundColor = UIColor.grade4.cgColor
            self.pm25Label.text = "매우 나쁨 " + self.pm25Str + " ㎍/㎥"
            self.pm25Label.textColor = UIColor.grade4
        }
    }
    
    // MARK : 오존 수치에 따른 view, label 설정 (ozone)
    func setOzoneString() -> Void {
        let ozoneToDouble = Double(self.ozoneStr)!
        
        switch ozoneToDouble{
        case let x where x<0.031 :
            self.ozoneView.layer.backgroundColor = UIColor.grade1.cgColor
            self.ozoneLabel.text = "좋음 " + self.ozoneStr + "ppm"
            self.ozoneLabel.textColor = UIColor.grade1
        case let x where x<0.091 :
            self.ozoneView.layer.backgroundColor = UIColor.grade2.cgColor
            self.ozoneLabel.text = "보통 " + self.ozoneStr + "ppm"
            self.ozoneLabel.textColor = UIColor.grade2
        case let x where x<0.151 :
            self.ozoneView.layer.backgroundColor = UIColor.grade3.cgColor
            self.ozoneLabel.text = "나쁨 " + self.ozoneStr + "ppm"
            self.ozoneLabel.textColor = UIColor.grade3
        default:
            self.ozoneView.layer.backgroundColor = UIColor.grade4.cgColor
            self.ozoneLabel.text = "매우 나쁨 " + self.ozoneStr + "ppm"
            self.ozoneLabel.textColor = UIColor.grade4
        }
    }
    
    // MARK : 일산화탄소 수치에 따른 view, label 설정 (co)
    func setCoString() -> Void {
        let coToDouble = Double(self.coStr)!
        switch coToDouble{
        case let x where x<0.031 :
            self.coView.layer.backgroundColor = UIColor.grade1.cgColor
            self.coLabel.text = "좋음 " + self.coStr + " ㎍/㎥"
            self.coLabel.textColor = UIColor.grade1
        case let x where x<0.091 :
            self.coView.layer.backgroundColor = UIColor.grade2.cgColor
            self.coLabel.text = "보통 " + self.coStr + " ㎍/㎥"
            self.coLabel.textColor = UIColor.grade2
        case let x where x<0.151 :
            self.coView.layer.backgroundColor = UIColor.grade3.cgColor
            self.coLabel.text = "나쁨 " + self.coStr + " ㎍/㎥"
            self.coLabel.textColor = UIColor.grade3
        default:
            self.coView.layer.backgroundColor = UIColor.grade4.cgColor
            self.coLabel.text = "매우 나쁨 " + self.coStr + " ㎍/㎥"
            self.coLabel.textColor = UIColor.grade4
        }
    }
    
    // MARK : 아황산가스 수치에 따른 view, label 설정 (so)
    func setSoString() -> Void {
        let soToDouble = Double(self.soStr)!
        switch soToDouble {
        case let x where x<0.021:
            self.soView.layer.backgroundColor = UIColor.grade1.cgColor
            self.soLabel.text = "좋음 " + self.soStr + " ㎍/㎥"
            self.soLabel.textColor = UIColor.grade1
        case let x where x<0.051:
            self.soView.layer.backgroundColor = UIColor.grade2.cgColor
            self.soLabel.text = "보통 " + self.soStr + " ㎍/㎥"
            self.soLabel.textColor = UIColor.grade2
        case let x where x<0.151:
            self.soView.layer.backgroundColor = UIColor.grade3.cgColor
            self.soLabel.text = "나쁨 " + self.soStr + " ㎍/㎥"
            self.soLabel.textColor = UIColor.grade3
        default:
            self.soView.layer.backgroundColor = UIColor.grade4.cgColor
            self.soLabel.text = "매우 나쁨 " + self.soStr + " ㎍/㎥"
            self.soLabel.textColor = UIColor.grade4
        }
    }
    
    // MARK : 이산화질소 수치에 따른 view, label 설정 (no)
    func setNoString() -> Void {
        let noToDouble = Double(self.noStr)!
        switch noToDouble {
        case let x where x<0.031:
            self.noView.layer.backgroundColor = UIColor.grade1.cgColor
            self.noLabel.text = "좋음 " + self.soStr + " ppm"
            self.noLabel.textColor = UIColor.grade1
        case let x where x<0.061:
            self.noView.layer.backgroundColor = UIColor.grade2.cgColor
            self.noLabel.text = "보통 " + self.soStr + " ppm"
            self.noLabel.textColor = UIColor.grade2
        case let x where x<0.201:
            self.noView.layer.backgroundColor = UIColor.grade3.cgColor
            self.noLabel.text = "나쁨 " + self.soStr + " ppm"
            self.noLabel.textColor = UIColor.grade3
        default:
            self.noView.layer.backgroundColor = UIColor.grade4.cgColor
            self.noLabel.text = "매우 나쁨 " + self.soStr + " ppm"
            self.noLabel.textColor = UIColor.grade4
        }
    }
    
}
