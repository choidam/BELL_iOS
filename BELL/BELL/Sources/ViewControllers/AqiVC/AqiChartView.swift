//
//  AqiChartView.swift
//  BELL
//
//  Created by 최은지 on 30/05/2020.
//  Copyright © 2020 최은지. All rights reserved.
//

import Foundation
import UIKit
import Macaw

struct SwiftNewsVideo {
    var showNumber: String
    var viewCount: Double
}

// aqi 지수 저장
struct AqiBar {
    var aqiIndex: Int
}

class AqiChartView: MacawView {
    
    static let lastFiveShows = createDummyData()
    static let maxValue = 600
    static let maxValueLineHeight = 180
    static let lineWidth: Double = 275
    
    static let dataDivisor = Double(maxValue/maxValueLineHeight)
    static let adjustedData: [Double] = lastFiveShows.map({ $0.viewCount / dataDivisor }) // $0 : each item
    static var animations: [Animation] = []
    
    required init?(coder aDecoder: NSCoder){
        super.init(node: AqiChartView.createChart(), coder: aDecoder)
        backgroundColor = UIColor.lightGray
    }
    
    private static func createChart() -> Group { // group : array of nodes
        var items:[Node] = addYAxisItems() + addXAxisItems()
        items.append(createBars())
        
        return Group(contents: items, place: .identity)
    }
    
    private static func addYAxisItems() -> [Node]{
        let maxLines = 6
        let lineInterval = Int(maxValue/maxLines)
        let yAxisHeight: Double = 200
        let lineSpacing: Double = 30
        
        var newNodes: [Node] = []
        
        for i in 1...maxLines {
            let y = yAxisHeight - (Double(i) * lineSpacing)
            let valueLine = Line(x1: -5, y1: y, x2: lineWidth, y2: y).stroke(fill: Color.white)
            let valueText = Text(text: "\(i * lineInterval)", align: .max, baseline: .mid, place: .move(dx: -10, dy: y))
            valueText.fill = Color.white
            
            newNodes.append(valueLine)
//            newNodes.append(valueText)
        }
        
        let yAxis = Line(x1: 0, y1: 0, x2: 0, y2: yAxisHeight).stroke(fill: Color.white.with(a: 0.25))
        newNodes.append(yAxis)
        
        return newNodes
    }
    
    private static func addXAxisItems() -> [Node]{
        let chartBaseY: Double = 200
        var newNodes: [Node] = []
        
        for i in 1...adjustedData.count {
            let x = (Double(i) * 50) // start
            let valueText = Text(text: lastFiveShows[i-1].showNumber, align: .max, baseline: .mid, place: .move(dx: x, dy: chartBaseY + 15))
            valueText.fill = Color.white
//            newNodes.append(valueText)
        }
        
        let xAxis = Line(x1: 0, y1: chartBaseY, x2: lineWidth, y2: chartBaseY).stroke(fill: Color.white.with(a: 0.25))
        newNodes.append(xAxis)
        
        return newNodes
    }
    
    private static func createBars() -> Group {
        
        let fill = LinearGradient(degree: 90, from: Color(val: 0xff4704), to: Color(val: 0xff4704).with(a: 0.33))
        let items = adjustedData.map { _ in Group() }
        
        // each bar animations
        animations = items.enumerated().map { (i:Int, item:Group) in // i : index
            item.contentsVar.animation(delay: Double(i)*0.2) { t in // animation : left to right
                let height = adjustedData[i]*t
                let rect = Rect(x: Double(i)*50+25, y: 200-height, w: 30, h: height)
                return [rect.fill(with: fill)]
            }
        }
        
        return items.group()
    }
    
    static func playAnimations(){ // not private (animation trigger)
        animations.combine().play()
    }
    
    // dummy data
    private static func createDummyData() -> [SwiftNewsVideo] {
        let one = SwiftNewsVideo(showNumber: "55", viewCount: 345)
        let two = SwiftNewsVideo(showNumber: "56", viewCount: 520)
        let three = SwiftNewsVideo(showNumber: "57", viewCount: 425)
        let four = SwiftNewsVideo(showNumber: "58", viewCount: 368)
        let five = SwiftNewsVideo(showNumber: "59", viewCount: 482)
       
        return [one, two, three, four, five]
    }
}
