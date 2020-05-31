//
//  AqiService.swift
//  BELL
//
//  Created by 최은지 on 01/06/2020.
//  Copyright © 2020 최은지. All rights reserved.
//

import Foundation

class AqiService {
    static let shared = AqiService()
    
    static let aqiKey = "g5wuVXrLzJMBI9kR2gmdXm6ltsn0zYEicoOG7g2xNHZnGZVp9v7znsIO45M2l7R6rlE5wiD%2FjtIZupMYvyN2Pg%3D%3D"
    static let aqiAddress1 = "http://openapi.airkorea.or.kr/openapi/services/rest/ArpltnInforInqireSvc/getMsrstnAcctoRltmMesureDnsty?stationName="
    static let aqiAddress2 = "&dataTerm=month&pageNo=1&numOfRows=10&ServiceKey=g5wuVXrLzJMBI9kR2gmdXm6ltsn0zYEicoOG7g2xNHZnGZVp9v7znsIO45M2l7R6rlE5wiD%2FjtIZupMYvyN2Pg%3D%3D&ver=1.3&_returnType=json"
    
    // MARK : 한글 인코딩
    func makeStringKoreanEncoded(_ string: String) -> String {
        return string.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) ?? string
    }
    
    // MARK : 한글 인코딩된 url 주소 변환
    func makeAqiAddress(region: String) -> String {
        let encodedRegion = makeStringKoreanEncoded(region)
        let encodedURL = AqiService.aqiAddress1 + encodedRegion + AqiService.aqiAddress2
        return encodedURL
    }
}
