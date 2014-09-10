//
//  GraphView.swift
//  CWSortTester
//
//  Created by Cezary Wojcik on 6/5/14.
//  Copyright (c) 2014 Cezary Wojcik. All rights reserved.
//

import UIKit

class GraphView: UIView {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.clearColor()
    }
    
    var swiftData: Array<Double>?
    var swiftColor: UIColor = UIColor.orangeColor()
    var objcData: Array<Double>?
    var objcColor: UIColor = UIColor.blueColor()
    
    var yMax : CGFloat = 0

    override func drawRect(rect: CGRect) {
        var context = UIGraphicsGetCurrentContext()
        
        if swiftData != nil {
            drawData(context, data: swiftData, color: swiftColor, rect: rect)
        }
        
        if objcData != nil {
            drawData(context, data: objcData, color: objcColor, rect: rect)
        }
    }
    
    func drawData(context: CGContext!, data: Array<Double>!, color: UIColor, rect: CGRect) {
        if CGFloat(data[data.count - 1]) > yMax {
            yMax = CGFloat(data[data.count - 1])
        }
        
        let yScale : CGFloat = rect.height / yMax
        let xCount = CGFloat(data.count - 1)
        let xScale : CGFloat = rect.width / xCount
        
        CGContextSetLineWidth(context, 2.0)
        CGContextSetStrokeColorWithColor(context, color.CGColor)
        CGContextMoveToPoint(context, 0, rect.height)
        for var x = 0; x < data.count; x++ {
            var xPoint : CGFloat = xScale * CGFloat(x)
            var yPoint : CGFloat = rect.height - yScale * CGFloat(data[x])
            CGContextAddLineToPoint(context, xPoint, yPoint)
            CGContextMoveToPoint(context, xPoint, yPoint)
        }
        
        CGContextStrokePath(context)
    }
    
    func drawSwiftGraph(data: Array<Double>) {
        self.yMax = 0
        self.swiftData = data
        self.setNeedsDisplay()
    }
    
    func drawObjcGraph(data: Array<Double>) {
        self.yMax = 0
        self.objcData = data
        self.setNeedsDisplay()
    }
    
}
