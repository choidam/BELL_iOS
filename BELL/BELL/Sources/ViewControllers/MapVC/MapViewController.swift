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
    
    var searchLocation: CLLocation! // 내가 검색한 위치
    
    @IBOutlet weak var InfoView: UIView! // 미세먼지 정보 view
    @IBOutlet weak var locationButton: UIButton!
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var addressDetailLabel: UILabel!
    @IBOutlet weak var aqiStatusLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    // MARK : 서울 구의 위치 정보
    let dobongLoc = CLLocationCoordinate2D(latitude: 37.6658609, longitude: 127.0317674) // 도봉구
    let eunpyeongLoc = CLLocationCoordinate2D(latitude: 37.6176125, longitude: 126.9227004) // 은평구
    let dongdaemoonLoc = CLLocationCoordinate2D(latitude: 37.5838012, longitude: 127.0507003) // 동대문구
    let dongjakLoc = CLLocationCoordinate2D(latitude: 37.4965037, longitude: 126.9443073) // 동작구
    let geumcheonLoc = CLLocationCoordinate2D(latitude: 37.4600969, longitude: 126.9001546) // 금천구
    let guroLoc = CLLocationCoordinate2D(latitude: 37.4954856, longitude: 126.858121) // 구로구
    let jongnoLoc = CLLocationCoordinate2D(latitude: 37.5990998, longitude: 126.9861493) // 종로구
    let gangbukLoc = CLLocationCoordinate2D(latitude: 37.6469954, longitude: 127.0147158) // 강북구
    let jungnangLoc = CLLocationCoordinate2D(latitude: 37.5953795, longitude: 127.0939669) // 중랑구
    let gangnamLoc = CLLocationCoordinate2D(latitude: 37.4959854, longitude: 127.0664091) // 강남구
    let gangseoLoc = CLLocationCoordinate2D(latitude: 37.5657617, longitude: 126.8226561) // 강서구
    let jungLoc = CLLocationCoordinate2D(latitude: 37.5579452, longitude: 126.9941904) // 중구
    let gangdongLoc = CLLocationCoordinate2D(latitude: 37.5492077, longitude: 127.1464824) // 강동구
    let gwangjinLoc = CLLocationCoordinate2D(latitude: 37.5481445, longitude: 127.0857528) // 광진구
    let mapoLoc = CLLocationCoordinate2D(latitude: 37.5622906, longitude: 126.9087803) // 마포구
    let seochoLoc = CLLocationCoordinate2D(latitude: 37.4769528, longitude: 127.0378103) // 서초구
    let seongbukLoc = CLLocationCoordinate2D(latitude: 37.606991, longitude: 127.0232185) // 성북구
    let nowonLoc = CLLocationCoordinate2D(latitude: 37.655264, longitude: 127.0771201) // 노원구
    let songpaLoc = CLLocationCoordinate2D(latitude: 37.5048534, longitude: 127.1144822) // 송파구
    let seoudaemoonLoc = CLLocationCoordinate2D(latitude: 37.5820369, longitude: 126.9356665) // 서대문구
    let yangcheonLoc = CLLocationCoordinate2D(latitude: 37.5270616, longitude: 126.8561534) // 양천구
    let yeongdeungpoLoc = CLLocationCoordinate2D(latitude: 37.520641, longitude: 126.9139242) // 영등포구
    let gwanakLoc = CLLocationCoordinate2D(latitude: 37.4653993, longitude: 126.9438071) // 관악구
    let seongdongLoc = CLLocationCoordinate2D(latitude: 37.5506753, longitude: 127.0409622) // 성동구
    let yongsanLoc = CLLocationCoordinate2D(latitude: 37.5311008, longitude: 126.9810742) // 용산구
    
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
        self.mapView.mapType = MKMapType.standard
        
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
    
    // MARK : 검색한 위치로 이동 & marker 추가
    func setMapView(coordinate: CLLocationCoordinate2D, addr: String){
        let region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta:0.01, longitudeDelta:0.01))
        self.mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = addr
        self.mapView.addAnnotation(annotation)
    }
    
    // MARK : 미세먼지 조회를 원하는 지역 검색
    @IBAction func clickSearchButton(_ sender: UIButton) {
        self.addressLabel.text = self.searchTextField.text
        
        switch addressLabel.text {
        case "도봉구":
            self.setMapView(coordinate: self.dobongLoc, addr: "도봉구")
        case "은평구":
            self.setMapView(coordinate: self.eunpyeongLoc, addr: "은평구")
        case "동대문구":
            self.setMapView(coordinate: self.dongdaemoonLoc, addr: "동대문구")
        case "동작구":
            self.setMapView(coordinate: self.dongjakLoc, addr: "동작구")
        case "금천구":
            self.setMapView(coordinate: self.geumcheonLoc, addr: "금천구")
        case "구로구":
            self.setMapView(coordinate: self.guroLoc, addr: "구로구")
        case "종로구":
            self.setMapView(coordinate: self.jongnoLoc, addr: "종로구")
        case "강북구":
           self.setMapView(coordinate: self.gangbukLoc, addr: "강북구")
        case "중랑구":
            self.setMapView(coordinate: self.jungnangLoc, addr: "중랑구")
        case "강남구":
            self.setMapView(coordinate: self.gangnamLoc, addr: "강남구")
        case "강서구":
            self.setMapView(coordinate: self.gangseoLoc, addr: "강서구")
        case "중구":
            self.setMapView(coordinate: self.jungLoc, addr: "중구")
        case "강동구":
            self.setMapView(coordinate: self.gangdongLoc, addr: "강동구")
        case "광진구":
            self.setMapView(coordinate: self.gwangjinLoc, addr: "광진구")
        case "마포구":
            self.setMapView(coordinate: self.mapoLoc, addr: "마포구")
        case "서초구":
            self.setMapView(coordinate: self.seochoLoc, addr: "서초구")
        case "성북구":
            self.setMapView(coordinate: self.seongbukLoc, addr: "성북구")
        case "노원구":
            self.setMapView(coordinate: self.nowonLoc, addr: "노원구")
        case "송파구":
            self.setMapView(coordinate: self.songpaLoc, addr: "송파구")
        case "서대문구":
            self.setMapView(coordinate: self.seoudaemoonLoc, addr: "서대문구")
        case "양천구":
            self.setMapView(coordinate: self.yangcheonLoc, addr: "양천구")
        case "영등포구":
            self.setMapView(coordinate: self.yeongdeungpoLoc, addr: "영등포구")
        case "관악구":
            self.setMapView(coordinate: self.gwanakLoc, addr: "관악구")
        case "성동구":
            self.setMapView(coordinate: self.seongdongLoc, addr: "성동구")
        case "용산구":
            self.setMapView(coordinate: self.yongsanLoc, addr: "용산구")
        default:
            let alert = UIAlertController(title: "잘못된 주소입니다.", message: "정확한 주소를 입력해주세요.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        self.searchTextField.text = ""
        
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
