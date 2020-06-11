//
//  MenuViewController.swift
//  BELL
//
//  Created by 최은지 on 09/06/2020.
//  Copyright © 2020 최은지. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loginButton.layer.borderWidth = 1
        self.loginButton.layer.borderColor = UIColor.gray.cgColor
        self.loginButton.layer.cornerRadius = 12

    }
    
    // MARK : 로그인
    @IBAction func goLogin(_ sender: UIButton) {
        let alert = UIAlertController(title: "서비스 준비중입니다.", message: "조금만 기다려주세요!", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK : 공지사항
    @IBAction func goNotice(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "NoticeViewController") as! NoticeViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK : 앱 정보
    @IBAction func goAppInfo(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AppInfoViewController") as! AppInfoViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK : 고객 지원
    @IBAction func goCustomer(_ sender: UIButton) {
        
    }
    
    // MARK : 이용 의견
    @IBAction func goOpinion(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "OpinionViewController") as! OpinionViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

}
