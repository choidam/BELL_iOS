//
//  AqiViewController.swift
//  BELL
//
//  Created by 최은지 on 27/05/2020.
//  Copyright © 2020 최은지. All rights reserved.
//

import UIKit
import CoreLocation

class AqiViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var aqiView: UIView! // 실시간 미세먼지 subview
    @IBOutlet weak var chartWholeView: UIView!
    @IBOutlet weak var graphView: AqiChartView! // 실시간 미세먼지 chart subview
    
    @IBOutlet weak var reloadButton: UIButton! // 위치 reload button
    
    @IBOutlet weak var addressLabel: UILabel! // 내 주소
    @IBOutlet weak var aqiStatusBigLabel: UILabel!
    @IBOutlet weak var aqiStatusSmallLabel: UILabel!
    @IBOutlet weak var EmojiImageView: UIImageView!
    
    @IBOutlet weak var goDetailButton: UIButton! // 더보기 버튼
    
    var locationManager: CLLocationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    @IBOutlet weak var weatherView: UIView!
    
    var aqiDataSet = [AqiResponseString]()
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager = manager
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentLocation = locationManager.location
        }
    }
    
    // 위치 허용 선택했을 때 처리
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined :
            manager.requestWhenInUseAuthorization()
            break
        case .authorizedWhenInUse:
            self.firstSetting()
            break
        case .authorizedAlways:
            self.firstSetting()
            break
        case .restricted :
            break
        case .denied :
            break
        default:
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.aqiView.setViewShadow()
        self.chartWholeView.setViewShadow()
        
        self.graphView.setViewShadow()
        self.graphView.contentMode = .scaleAspectFit
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
        
        self.animateEmojiImage()
        Timer.scheduledTimer(withTimeInterval: 3, repeats: true, block: { _ in
            self.animateEmojiImage()
        })
        
    }
    
    // MARK : 위치 받아오기 에러 처리
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if CLLocationManager.locationServicesEnabled() {
            if CLLocationManager.authorizationStatus() == .denied || CLLocationManager.authorizationStatus() == .restricted {
                let alert = UIAlertController(title: "오류 발생", message: "위치 서비스 기능이 꺼져있음", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            } else {
                locationManager.desiredAccuracy = kCLLocationAccuracyBest
                locationManager.delegate = self
                locationManager.requestWhenInUseAuthorization()
            }
        } else {
            let alert = UIAlertController(title: "오류 발생", message: "위치 서비스 제공 불가", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
        
        // 이미 허용인 경우 처리
        if CLLocationManager.authorizationStatus() == .authorizedAlways || CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            self.firstSetting()
        }
        
        self.weatherView.setGradientBackground(colorTop: UIColor.white, colorBottom: UIColor.skyblue)
        self.weatherView.setViewShadow()
        self.weatherView.layer.cornerRadius = 3
    }
    
    @IBAction func clickReloadButton(_ sender: UIButton) {
        // rotate animation
        UIView.animate(withDuration: 0.5) { () -> Void in
            self.reloadButton.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        }
        UIView.animate(withDuration: 0.5, delay: 0.5, options: UIView.AnimationOptions.curveEaseIn, animations: { () -> Void in
            self.reloadButton.transform = CGAffineTransform(rotationAngle: CGFloat.pi * 2.0)
        }, completion: nil)
        
        // reload chart animation
        AqiChartView.playAnimations()
    }
    
    func firstSetting(){
        // find location and address
        self.currentLocation = locationManager.location
        print(self.currentLocation.coordinate.latitude)
        print(self.currentLocation.coordinate.longitude)
        self.findAddr(lat: self.currentLocation.coordinate.latitude, long: self.currentLocation.coordinate.longitude)
        
        // play chart animation
        AqiChartView.playAnimations()
    }
    
    func findAddr(lat: CLLocationDegrees, long: CLLocationDegrees){
        
        let findLocation = CLLocation(latitude: lat, longitude: long)
        let geocoder = CLGeocoder()
        let locale = Locale(identifier: "Ko-kr")
        
        geocoder.reverseGeocodeLocation(findLocation, preferredLocale: locale, completionHandler: {(placemarks, error) in
            if let address: [CLPlacemark] = placemarks {
                if let name: String = address.last?.name {
                    self.addressLabel.text = name // 남가좌동 50-3
                }
                if let area: String = address.last?.locality{
                    print("findaddress : ", area) // 서대문구
                    self.connectAqiAPI(region: area)
                }
            }
        })
    }
    
    // 더보기 페이지로 이동
    @IBAction func moveDetail(_ sender: UIButton) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "AqiDetailViewController") else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func animateEmojiImage(){
        self.EmojiImageView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        UIView.animate(
            withDuration: 1.2,
            delay: 0,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 0.2,
            options: .curveEaseOut,
            animations: {
                self.EmojiImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
        }, completion: nil)
    }
    
    // MARK : 미세먼지 API 연결
    func connectAqiAPI(region: String){
        let aqiURLString = AqiService.shared.makeAqiAddress(region: region)
        let aqiURL = URL(string: aqiURLString)!
        
        do {
            let responseString = try String(contentsOf: aqiURL)
            guard let data = responseString.data(using: .utf8) else { return }
            let decoder = JSONDecoder()
            if let object = try? decoder.decode(AqiResponseString.self, from: data) {
                self.aqiDataSet = [object] as! [AqiResponseString]
//                self.misaeLabel.text = self.aqiDataSet[0].list![0].pm25Value
//                self.dateLabel.text = self.aqiDataSet[0].list![0].dataTime
                print(self.aqiDataSet[0].list![0].pm25Value)
                print(self.aqiDataSet[0].list![0].dataTime)
            }
        } catch let e as NSError {
            print(e.localizedDescription)
        }
    }
}

