//
//  APChartMarker1.swift
//  HomeControl
//
//  Created by Przemyslaw Kromólski on 02/06/2019.
//  Copyright © 2019 Przemyslaw Kromólski. All rights reserved.
//

import UIKit
import QuartzCore
struct APMarker1 {
    var value:CGFloat
    var point:CGFloat
    var pointEnd:CGFloat
    var label:String
}
class APChartMarkerLine1  {
    var chart:APChartView1
    var x:APMarker1?
    var y:APMarker1?
    var title:String = "line"
    var lineColor:UIColor = UIColor.black
    var lineWidth:CGFloat = 1.0
    init(chartView:APChartView1, title:String, x:CGFloat, lineColor:UIColor? =  UIColor.red) {
        self.chart = chartView
        self.title = title
        self.lineColor = lineColor!
        self.x = APMarker1(value: x, point: x, pointEnd:x, label: title)
    }
    init(chartView:APChartView1, title:String, y:CGFloat, lineColor:UIColor? =  UIColor.red) {
        self.chart = chartView
        self.title = title
        self.lineColor = lineColor!
        self.y = APMarker1(value: y, point: y, pointEnd:y, label: title)
        
    }
    
    func updatePoints(_ factorPoint:CGPoint, offset:CGPoint){
        
        if let x_marker = x {
            x?.point = x_marker.value.updatePointX(factorPoint.x, offset.x)
            return
        }
        
        if let y_marker = y {
            y?.point = y_marker.value.updatePointY(factorPoint.y, offset.y)
            return
        }
        
    }
    
    
    func drawLine() -> CAShapeLayer? {
        //        let currentLine = linesDataStore[lineIndex]
        
        let bpath = UIBezierPath()
        
        var labelTitle:UILabel?
        var labelValue:UILabel?
        if let x_marker = x
        {
            labelTitle = UILabel(frame: CGRect(origin: CGPoint(x: x_marker.point-8.0, y: chart.pointZero.y-chart.drawingArea.height), size: chart.labelAxesSize))
            labelTitle?.transform = CGAffineTransform(rotationAngle: -CGFloat.pi/2)
            labelValue = UILabel(frame: CGRect(origin: CGPoint(x: x_marker.point-24.0, y: chart.pointZero.y-chart.drawingArea.height), size: chart.labelAxesSize))
            labelValue?.transform = CGAffineTransform(rotationAngle: -CGFloat.pi/2)
            labelValue?.text = "\(x_marker.value)"
            
            bpath.move(to: CGPoint(x: x_marker.point, y: chart.pointZero.y))
            bpath.addLine(to: CGPoint(x: x_marker.point, y: chart.pointZero.y-chart.drawingArea.height))
            
        }
        
        if let y_marker = y
        {
            labelTitle = UILabel(frame: CGRect(origin: CGPoint(x: chart.pointZero.x+chart.drawingArea.width-chart.labelAxesSize.width-255, y: y_marker.point), size: chart.labelAxesSize))
            labelValue = UILabel(frame: CGRect(origin: CGPoint(x: chart.pointZero.x+chart.drawingArea.width-chart.labelAxesSize.width-255, y: y_marker.point-16), size: chart.labelAxesSize))
            //labelValue?.text = "\(y_marker.value)"
            labelValue?.text = String(format: "%.2f", y_marker.value)
            bpath.move(to: CGPoint(x: chart.pointZero.x, y: y_marker.point))
            bpath.addLine(to: CGPoint(x: chart.pointZero.x+chart.drawingArea.width, y: y_marker.point))
        }
        
        
        labelTitle?.font = UIFont.italicSystemFont(ofSize: 10.0)
        labelTitle?.textAlignment = .right
        labelTitle?.text = "\(title)"
        labelTitle?.sizeToFit()
        labelTitle?.textColor = lineColor
        chart.addSubview(labelTitle!)
        labelValue?.font = UIFont.italicSystemFont(ofSize: 10.0)
        labelValue?.textAlignment = .right
        labelValue?.sizeToFit()
        labelValue?.textColor = lineColor
        chart.addSubview(labelValue!)
        
        
        UIColor.clear.setStroke()
        bpath.lineCapStyle = CGLineCap.round
        bpath.stroke()
        //
        let layer = CAShapeLayer()
        layer.frame = self.chart.bounds
        layer.path = bpath.cgPath
        layer.strokeColor = lineColor.cgColor //colors[lineIndex].CGColor
        layer.fillColor = nil
        layer.lineWidth = lineWidth
        layer.lineDashPattern = [6,2]
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = 1.0
        animation.fromValue = 0
        animation.toValue = 1
        layer.add(animation, forKey: "strokeEnd")
        
        
        
        return layer
    }
    
    
}
