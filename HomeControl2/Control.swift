//
//  Control.swift
//  HomeControl
//
//  Created by Przemyslaw Kromólski on 01/06/2019.
//  Copyright © 2019 Przemyslaw Kromólski. All rights reserved.
//

import UIKit
//https://github.com/ameizi/awesome-ios-chart
//https://github.com/tylyo/APLineChart

class Control: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, APChartViewDelegate1, APChartViewDelegate2, APChartViewDelegate3  {
    
    

   
    @IBOutlet weak var chart1: APChartView1!
    @IBOutlet weak var chart2: APChartView2!
    @IBOutlet weak var chart3: APChartView3!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var labelMomentPowerUse: UITextView!
    @IBOutlet weak var labelFuturePowerUse: UITextView!
    @IBOutlet weak var hideChartMoment: UIView!
    
    static var powerUseH:[Double]=[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23]
    var tab:[CGFloat] = [0.0,0.0]
    var pickerData: [String] = [String]()
    
    var mocZapotrzebowanie : [Double] =  [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23]
    var moc1 : [Double] =  [30,   60,  205,  0,   0,   200,  270,  0,    0]
    //czas=x - caly dzien
    var czas : [Double] = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23]
    var viewX : [CGFloat] = [70,80,90,102,112,122,135,145,155,170,180,190,200,210,220,235,245,255,267,277,287,300,310,320,332]
    

   

    override func viewDidLoad() {
        super.viewDidLoad()
        moveHideScreen()
        chart1.delegate = self
        chart2.delegate = self
        chart3.delegate = self
        showChart1()
        
        //pickerView Do usuniecia
        picker.delegate = self
        picker.dataSource = self
        
        pickerData = ["Algorytm nr 1", "Algorytm nr 2", "Algorytm nr 3"]
        //pickerView koniec usuniecia
        labelMomentPowerUse.text = "\(MyVariables.powerMoment ) kWh"
        labelFuturePowerUse.text = "\(MyVariables.powerPredictet ) kWh"
        
    }
    //Funnkcja zlicza wartosci z danej godziny z wszystkich urzadzeń
    func addPower() {
        DataBuffor().start()
        for i in 0...23 {
            Control.powerUseH[i] = MyVariables.room1[i,0] + MyVariables.room2[i,0] + MyVariables.room3[i,0] + MyVariables.room4[i,0] + MyVariables.room5[i,0] + MyVariables.room6[i,0]
//            if Control.powerUseH[i]>0 {
//                Control.powerUseH[i]+=24
//            }
            Control.powerUseH[i] = Control.powerUseH[i].roundToDecimal(2)
            
            print("\(i) = \(Control.powerUseH[i])")
        }
       
    }
    func moveHideScreen()
    {
        let dateFormatter : DateFormatter = DateFormatter()
        //        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.dateFormat = "HH"
        let date = Date()
        let dateString = dateFormatter.string(from: date)
        print(dateString)
        self.hideChartMoment.frame.origin.x = viewX[Int(dateString)!]
        MyVariables.timeDate = Int(dateString)!
        
        
    }
    //algorytm 1
    func showChart1(){
        addPower()
        chart1.isHidden = false
        chart2.isHidden = true
        chart3.isHidden = true
        chart1.collectionLines = []
        let line = APChartLine1(chartView: chart1, title: "moment", lineWidth: 3.0, lineColor: UIColor.green)
        let line2 = APChartLine1(chartView: chart1, title: "max", lineWidth: 1.0, lineColor: UIColor.red)

        //add points to this line:
        for i in 0...5 {
            line2.addPoint( CGPoint(x: czas[i], y: Control.powerUseH[i]))
            line.addPoint( CGPoint(x: czas[i], y: Control.powerUseH[i]))
        }
        for i in 6...9{
            //
            let number = [0,0,0 ,0.01, 0.02, 0.03 , 0.04, 0.05]
            let random = number.randomElement()!
            print("Random: \(random)")
            let temp = Control.powerUseH[MyVariables.timeDate] + random
            print("Sprawdz to: \(temp)")
            MyVariables.powerPredictet = String(temp.roundToDecimal(2))
            MyVariables.powerMoment = String(Control.powerUseH[MyVariables.timeDate])
            //
                let adding = Control.powerUseH[i] + random
                line.addPoint( CGPoint(x: czas[i], y: Control.powerUseH[i]))
                line2.addPoint( CGPoint(x: czas[i], y: adding ))
                print("\(i) \(Control.powerUseH[i])")
                print("\(i) \(Control.powerUseH[i]+random)")
        }
        for i in 10...15 {
            //line2.addPoint( CGPoint(x: czas[i], y: Control.powerUseH[i]))
            line.addPoint( CGPoint(x: czas[i], y: Control.powerUseH[i]))
        }
        for i in 16...23 {
            //
            let number = [0,0,0 ,0.01, 0.02, 0.03 , 0.04, 0.05]
            let random = number.randomElement()!
            print("Random: \(random)")
            let temp = Control.powerUseH[MyVariables.timeDate] + random
            print("Sprawdz to: \(temp)")
            MyVariables.powerPredictet = String(temp.roundToDecimal(2))
            MyVariables.powerMoment = String(Control.powerUseH[MyVariables.timeDate])
            //
            let adding = Control.powerUseH[i] + random
            line.addPoint( CGPoint(x: czas[i], y: Control.powerUseH[i]))
            line2.addPoint( CGPoint(x: czas[i], y: adding ))
            print("\(i) \(Control.powerUseH[i])")
            print("\(i) \(Control.powerUseH[i]+random)")
        }
        // and add the line to the chart:
        chart1.addLine(line)
        //chart1.addLine(line2)
        chart1.setNeedsDisplay()
        print(Control.powerUseH)
    }
     //algorytm 2
    func showChart2(){
        chart1.isHidden = true
        chart2.isHidden = false
        chart3.isHidden = true
        chart2.collectionLines = []
        let line = APChartLine2(chartView: chart2, title: "moment", lineWidth: 3.0, lineColor: UIColor.green)
        let line2 = APChartLine2(chartView: chart2, title: "max", lineWidth: 1.0, lineColor: UIColor.red)
        //add points to this line:
        
        for i in 0...5 {
            line2.addPoint( CGPoint(x: czas[i], y: Control.powerUseH[i] ))
            line.addPoint( CGPoint(x: czas[i], y: Control.powerUseH[i]))
        }
        for i in 6...9 {
            //
            let number = [-0.05,-0.04,-0.03,-0.02,-0.01,0,0,0 ,0.01, 0.02, 0.03 , 0.04, 0.05]
            var random:Double = number.randomElement()!
            var temp = Control.powerUseH[MyVariables.timeDate] + random
            MyVariables.powerPredictet = String(temp.roundToDecimal(2))
            MyVariables.powerMoment = String(Control.powerUseH[MyVariables.timeDate])
            //
            var predictScore:Double = Control.powerUseH[i] + random
            if predictScore == Control.powerUseH[i]{
                Control.powerUseH[i] = Control.powerUseH[i]/2
                
            }
            line.addPoint( CGPoint(x: czas[i], y: Control.powerUseH[i]))
            if Control.powerUseH[i] + random  < 0{
                line2.addPoint( CGPoint(x: czas[i], y: Control.powerUseH[i]))
            } else {
                line2.addPoint( CGPoint(x: czas[i], y:predictScore  ))
            }
        }
        for i in 10...15 {
            line2.addPoint( CGPoint(x: czas[i], y: Control.powerUseH[i]))
            line.addPoint( CGPoint(x: czas[i], y: Control.powerUseH[i]))
        }
        for i in 16...23 {
            //
            let number = [-0.05,-0.04,-0.03,-0.02,-0.01,0,0,0 ,0.01, 0.02, 0.03 , 0.04, 0.05]
            var random:Double = number.randomElement()!
            var temp = Control.powerUseH[MyVariables.timeDate] + random
            MyVariables.powerPredictet = String(temp.roundToDecimal(2))
            MyVariables.powerMoment = String(Control.powerUseH[MyVariables.timeDate])
            //
            var predictScore:Double = Control.powerUseH[i] + random
            if predictScore == Control.powerUseH[i]{
                Control.powerUseH[i] = Control.powerUseH[i]/2
                
            }
            line.addPoint( CGPoint(x: czas[i], y: Control.powerUseH[i]))
            if Control.powerUseH[i] + random  < 0{
                line2.addPoint( CGPoint(x: czas[i], y: Control.powerUseH[i]))
            } else {
                line2.addPoint( CGPoint(x: czas[i], y:predictScore  ))
            }
        }
        // and add the line to the chart:
        chart2.addLine(line)
        chart2.addLine(line2)
        chart2.setNeedsDisplay()
        
    }
     //algorytm 3
    func showChart3(){
        addPower()
        chart1.isHidden = true
        chart2.isHidden = true
        chart3.isHidden = false
        chart3.collectionLines = []
        let line = APChartLine3(chartView: chart3, title: "moment", lineWidth: 3.0, lineColor: UIColor.green)
        let line2 = APChartLine3(chartView: chart3, title: "max", lineWidth: 1.0, lineColor: UIColor.red)

        //add points to this line:
        for i in 0...23{//linia moment
            
            line.addPoint( CGPoint(x: czas[i], y: Control.powerUseH[i]))
        
        }
        for i in 0...5 {
            line2.addPoint( CGPoint(x: czas[i], y: Control.powerUseH[i]))
        }
        for i in 6...9 {
            //
            let number = [-0.05,-0.04,-0.03,-0.02,-0.01,0,0,0 ,0.01, 0.02, 0.03 , 0.04, 0.05]
            let random:Double = number.randomElement()!
            let temp = Control.powerUseH[MyVariables.timeDate] + random
            MyVariables.powerPredictet = String(temp.roundToDecimal(2))
            MyVariables.powerMoment = String(Control.powerUseH[MyVariables.timeDate])
            //
            if Control.powerUseH[i] + random  < 0{
                line2.addPoint( CGPoint(x: czas[i], y: Control.powerUseH[i]))
            } else {
                line2.addPoint( CGPoint(x: czas[i], y: Control.powerUseH[i] + random))
            }
        }
        for i in 10...15 {
            line2.addPoint( CGPoint(x: czas[i], y: Control.powerUseH[i]))
        }
        for i in 16...23 {
            //
            let number = [-0.05,-0.04,-0.03,-0.02,-0.01,0,0,0 ,0.01, 0.02, 0.03 , 0.04, 0.05]
            let random:Double = number.randomElement()!
            let temp = Control.powerUseH[MyVariables.timeDate] + random
            MyVariables.powerPredictet = String(temp.roundToDecimal(2))
            MyVariables.powerMoment = String(Control.powerUseH[MyVariables.timeDate])
            //
            if Control.powerUseH[i] + random  < 0{
            line2.addPoint( CGPoint(x: czas[i], y: Control.powerUseH[i]))
            } else {
            line2.addPoint( CGPoint(x: czas[i], y: Control.powerUseH[i] + random ))
            }
        }
        // and add the line to the chart:
        chart3.addLine(line)
        chart3.addLine(line2)
        chart3.setNeedsDisplay()
    }
 
    //pickerView do usunicia potem
    func numberOfComponents(in picker: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ picker: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return pickerData[row]
       
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        print(pickerData[row])
        // tutaj zmienamy wyglad statystk
        switch pickerData[row] {
        case "Algorytm nr 1":
            showChart1()
            labelMomentPowerUse.text = "\(MyVariables.powerMoment ) kWh"
            labelFuturePowerUse.text = "\(MyVariables.powerPredictet ) kWh"
        case "Algorytm nr 2":
            showChart2()
            labelMomentPowerUse.text = "\(MyVariables.powerMoment ) kWh"
            labelFuturePowerUse.text = "\(MyVariables.powerPredictet ) kWh"
        case "Algorytm nr 3":
            showChart3()
            labelMomentPowerUse.text = "\(MyVariables.powerMoment ) kWh"
            labelFuturePowerUse.text = "\(MyVariables.powerPredictet ) kWh"
        default:
            print("Coś poszło nie tak")
        }
        // use the row to get the selected row from the picker view
        // using the row extract the value from your datasource (array[row])
    }
    //pickerView koniec usuniecia
    
    
    func didSelectNearDataPoint1(_ selectedDots: [String : APChartPoint1]) {
        var txt = ""
        var i:Int = 0
        for (title,value) in selectedDots {
            tab [i] = value.dot.y
            txt = "\(txt)\(title): \(value.dot.y)\n"
            i+=1
            if i==2 {i=0}
        }
        labelMomentPowerUse.text = "\(MyVariables.powerMoment ) kWh"
        labelFuturePowerUse.text = "\(MyVariables.powerPredictet ) kWh"
//        labelMomentPowerUse.text = "\(String(format: "%.0f", Double(tab[0]))) kWh"
//        labelFuturePowerUse.text = "\(String(format: "%.0f", Double(tab[1]))) kWh"
    }
    func didSelectNearDataPoint2(_ selectedDots: [String : APChartPoint2]) {
        var txt = ""
        var i:Int = 0
        for (title,value) in selectedDots {
            print("przed",i)
            tab [i] = value.dot.y
            txt = "\(txt)\(title): \(value.dot.y)\n"
            i+=1
            print("po",i)
            if i==2 {i=0}
        }
        labelMomentPowerUse.text = "\(MyVariables.powerMoment ) kWh"
        labelFuturePowerUse.text = "\(MyVariables.powerPredictet ) kWh"
//        labelMomentPowerUse.text = "\(String(format: "%.0f", Double(tab[0]))) kWh"
//        labelFuturePowerUse.text = "\(String(format: "%.0f", Double(tab[1]))) kWh"
    }
    func didSelectNearDataPoint3(_ selectedDots: [String : APChartPoint3]) {
        var txt = ""
        var i:Int = 0
        for (title,value) in selectedDots {
            tab [i] = value.dot.y
            txt = "\(txt)\(title): \(value.dot.y)\n"
            i+=1
            if i==2 {i=0}
        }
        labelMomentPowerUse.text = "\(MyVariables.powerMoment) kWh"
        labelFuturePowerUse.text = "\(MyVariables.powerPredictet) kWh"
//        labelMomentPowerUse.text = "\(String(format: "%.0f", Double(tab[0]))) kWh"
//        labelFuturePowerUse.text = "\(String(format: "%.0f", Double(tab[1]))) kWh"
    }

}
extension Double {
    func roundToDecimal(_ fractionDigits: Int) -> Double {
        let multiplier = pow(10, Double(fractionDigits))
        return Darwin.round(self * multiplier) / multiplier
    }
}
