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
    @IBOutlet weak var graphView: UIView! // 실시간 미세먼지 chart subview
    
    @IBOutlet weak var reloadButton: UIButton! // 위치 reload button
    
    var locationManager: CLLocationManager = CLLocationManager()
    var currentLocation: CLLocation! // 현재 위치
    
    func authorizelocationStates(){
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentLocation = locationManager.location
            print(currentLocation?.coordinate.latitude)
            print(currentLocation?.coordinate.longitude)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager = manager
        authorizelocationStates()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.aqiView.setViewShadow()
        self.graphView.setViewShadow()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
        
    }
    
    
    @IBAction func clickReloadButton(_ sender: UIButton) {
        // rotate animation
        UIView.animate(withDuration: 0.5) { () -> Void in
            self.reloadButton.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        }
        UIView.animate(withDuration: 0.5, delay: 0.5, options: UIView.AnimationOptions.curveEaseIn, animations: { () -> Void in
            self.reloadButton.transform = CGAffineTransform(rotationAngle: CGFloat.pi * 2.0)
        }, completion: nil)
        
        // location update
        print("@press@")
        let coor = locationManager.location?.coordinate
        print(coor?.latitude)
        print(coor?.longitude)
        
    }
    
}
