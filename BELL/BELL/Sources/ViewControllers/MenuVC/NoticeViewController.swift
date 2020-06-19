//
//  NoticeViewController.swift
//  BELL
//
//  Created by 최은지 on 11/06/2020.
//  Copyright © 2020 최은지. All rights reserved.
//

import UIKit

class NoticeViewController: UIViewController {
    
    @IBOutlet weak var serviceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.serviceLabel.numberOfLines = 0
        self.serviceLabel.text = """
            안녕하세요, \n
            BELL 운영자 입니다. \n \n
            BELL 서비스가 1.0 버전으로 처음 출시되었습니다. \n
        
            1. 1.0 출시 일시 : 2020년 6월 20일 (토요일) \n
            2. 주요 기능 \n
            - 실시간 미세먼지 조회 \n
            - 공기 지도 조회 \n
            - 캐릭터 중심의 UI 적용 \n \n
        
            BELL 앱 버전은 [설정 > 앱 정보] 에서 확인하실 수 있습니다.
        """
        
        
        
    }
    

    

}
