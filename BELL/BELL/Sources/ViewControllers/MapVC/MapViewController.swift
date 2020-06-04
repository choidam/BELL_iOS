//
//  MapViewController.swift
//  BELL
//
//  Created by 최은지 on 27/05/2020.
//  Copyright © 2020 최은지. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var searchTextField: UITextField! // 지역 검색 text field
    
    var locationManager: CLLocationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    @IBOutlet weak var InfoView: UIView! // 미세먼지 정보 view
    @IBOutlet weak var locationButton: UIButton!
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var addressDetailLabel: UILabel!
    @IBOutlet weak var aqiStatusLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var aqiDataSet = [AqiResponseString]() // aqi dataset
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager = manager
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentLocation = locationManager.location
        }
    }
    
    // MARK : 위치 허용 선택했을 때 처리
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
        
        self.mapView.showsUserLocation = true
        self.mapView.setUserTrackingMode(.follow, animated: true)
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
        
        self.InfoView.clipsToBounds = true
        self.InfoView.layer.cornerRadius = 10
        
        self.locationButton.clipsToBounds = true
        self.locationButton.layer.cornerRadius = 10
        
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer()
        tapGesture.delegate = self
        
        self.view.addGestureRecognizer(tapGesture)
    }
    
    // MARK : tap gesture
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    // MARK : 원래 내 위치로 되돌아가기
    @IBAction func clickLocationButton(_ sender: UIButton) {
        self.mapView.showsUserLocation = true
        self.mapView.setUserTrackingMode(.follow, animated: true)
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
    }
    
    // MARK : find location and address
    func firstSetting(){
        self.currentLocation = locationManager.location
        print(self.currentLocation.coordinate.latitude)
        print(self.currentLocation.coordinate.longitude)
        self.findAddr(lat: self.currentLocation.coordinate.latitude, long: self.currentLocation.coordinate.longitude)
    }
    
    // MARK : 위도, 경도에 따른 주소 찾기
    func findAddr(lat: CLLocationDegrees, long: CLLocationDegrees){
        let findLocation = CLLocation(latitude: lat, longitude: long)
        let geocoder = CLGeocoder()
        let locale = Locale(identifier: "Ko-kr")
        
        geocoder.reverseGeocodeLocation(findLocation, preferredLocale: locale, completionHandler: {(placemarks, error) in
            if let address: [CLPlacemark] = placemarks {
                var myAdd: String = ""
                if let area: String = address.last?.locality{
                    myAdd += area
                    self.addressLabel.text = area
                    self.connectAqiAPI(region: area) // 미세먼지 API 연결
                }
                if let name: String = address.last?.name {
                    myAdd += " "
                    myAdd += name
                }
                self.addressDetailLabel.text = myAdd
            }
        })
    }
    
    // MARK : 미세먼지 조회를 원하는 지역 검색
    @IBAction func clickSearchButton(_ sender: UIButton) {
        self.connectAqiAPI(region: self.searchTextField.text ?? "" )
        self.addressLabel.text = self.searchTextField.text
        self.searchTextField.text = ""
        
        // TODO : MAP View 의 위치를 내가 검색한 위치로 옮기기, 상세 위치 알아오기
        
    }
    
    // MARK : 미세먼지 API 연결 + 미세먼지 수치 뷰에 그리기
    func connectAqiAPI(region: String){
        let aqiURLString = AqiService.shared.makeAqiAddress(region: region)
        let aqiURL = URL(string: aqiURLString)!
        
        do {
            let responseString = try String(contentsOf: aqiURL)
            guard let data = responseString.data(using: .utf8) else { return }
            let decoder = JSONDecoder()
            if let object = try? decoder.decode(AqiResponseString.self, from: data) {
                self.aqiDataSet = [object] as! [AqiResponseString]
                let aqi10Str = self.getPm10String(pm10: self.aqiDataSet[0].list![0].pm10Value!)
                self.aqiStatusLabel.text = region + "의 공기 상태는 " + aqi10Str + "입니다."
                self.timeLabel.text = self.aqiDataSet[0].list![0].dataTime! + " 기준"
            }
        } catch let e as NSError {
            print(e.localizedDescription)
        }
    }
    
    // MARK : 미세먼지 수치에 따른 기준 (pm10)
    func getPm10String(pm10: String) -> String {
        guard let pm10Int = Int(pm10) else { return "정보 없음" }
        var pm10Str: String = ""
        
        switch pm10Int {
        case let x where x <= 30 :
            pm10Str = "좋음"
        case let x where x <= 80 :
            pm10Str = "보통"
        case let x where x <= 150 :
            pm10Str = "나쁨"
        default:
            pm10Str = "매우 나쁨"
        }
        return pm10Str
    }
}
