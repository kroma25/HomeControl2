//
//  Stats.swift
//  HomeControl
//
//  Created by Przemyslaw Kromólski on 02/06/2019.
//  Copyright © 2019 Przemyslaw Kromólski. All rights reserved.
//

import UIKit

struct MyVariables {
    static var state:String = "" //Month lub Year
    static var stateWindowBlinds = "Pomieszczenie nr 1"
    static var statePickerBrightness = "Pomieszczenie nr 1"
    static var statePickerValve = "Pomieszczenie nr 1"
    static var angle = ["Pomieszczenie nr 1" : 0,
                        "Pomieszczenie nr 2" : 30,
                        "Pomieszczenie nr 3" : -50,
                        "Pomieszczenie nr 4" : 26,
                        "Pomieszczenie nr 5" : 100,
                        "Pomieszczenie nr 6" : -46]
    
    static var brightness = ["Pomieszczenie nr 1" : 0,
                             "Pomieszczenie nr 2" : 0,
                             "Pomieszczenie nr 3" : 0,
                             "Pomieszczenie nr 4" : 0,
                             "Pomieszczenie nr 5" : 0,
                             "Pomieszczenie nr 6" : 0]
    static var valve =      ["Pomieszczenie nr 1" : 23.0,
                             "Pomieszczenie nr 2" : 22.0,
                             "Pomieszczenie nr 3" : 23.0,
                             "Pomieszczenie nr 4" : 24.0,
                             "Pomieszczenie nr 5" : 21.0,
                             "Pomieszczenie nr 6" : 19.0]
    static var valveChange = ["Pomieszczenie nr 1" : 15.0,
                             "Pomieszczenie nr 2" : 15.0,
                             "Pomieszczenie nr 3" : 14.0,
                             "Pomieszczenie nr 4" : 13.0,
                             "Pomieszczenie nr 5" : 15.0,
                             "Pomieszczenie nr 6" : 15.0]
    
    
    //
    static var room1 = DataBuffor.Matrix.init(rows: 24, columns: 7)
    static var room2 = DataBuffor.Matrix.init(rows: 24, columns: 7)
    static var room3 = DataBuffor.Matrix.init(rows: 24, columns: 7)
    static var room4 = DataBuffor.Matrix.init(rows: 24, columns: 7)
    static var room5 = DataBuffor.Matrix.init(rows: 24, columns: 7)
    static var room6 = DataBuffor.Matrix.init(rows: 24, columns: 7)
    static var powerMoment = "XX.X kWh"
    static var powerPredictet = "XX.X kWh"
    static var timeDate:Int = 0
    static var levelLightings:Double = 0
}


class Stats: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, APChartViewDelegate{

    @IBOutlet weak var chart: APChartView!
    @IBOutlet weak var pickerDay: UIDatePicker!
    @IBOutlet weak var pickerMonth: UIPickerView!
    @IBOutlet weak var pickerYear: UIPickerView!
    var state:String = "Day" //Month lub Year
    
    
    var moc1 : [Double] =  [30,   60,  205,  0,   0,   200,  270,  0,    0,30,   60,  205,  0,   0,   200,  270,  0,    0,30,   60,  205,  0,   0,   200,  270,  0,    0]
    var month : [Double] = [   1,  2,    3,   4,  5,   6,   7,   8,9,   10, 11, 12]
    var month2 : [Double] = [   0,  3,    6,   9,  12,   15,   18,   21,24,   27, 30]
    var czas : [Double] = [0,   1,  2,    3,   4,  5,   6,   7,   8,9,   10, 11, 12,   12,  15,   18,   21,   24,0,   3,  6,    9,   12,  15,   18,   21,   24,0,   3,  6,    9,   12,  15,   18,   21,   24]
    //Dane miesieczne - wstepne
    var monthX : [Double] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29]
    static var tableStats:[Double]=[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    //Dane roczne - wstepne
    var rokX : [Double] = [0,   1,  2,    3,   4,  5,   6,   7,   8,9,   10, 11]
    var rokYzuzycie : [Double] =  [30,   60,  205,  0,   0,   200,  270,  0,    0,30,   60,  205, 230]
    let months = ["Styczeń", "Luty", "Marzec",
                  "Kwiecień", "Maj", "Czerwiec",
                  "Lipiec", "Sierpień", "Wrzesień",
                  "Październik", "Listopad", "Grudzień"] //stałe wykorzystywane przez roller
    let year = ["2015","2016","2017","2018"] //stałe wykorzystywane przez roller
    var pickerData: [String] = [String]()
    var pickerData1:[String] = [String]()
    //####################
    override func viewDidLoad() { //załadowanie widoku
        super.viewDidLoad()
        MyVariables.state = "Day" // przekazanie co ma pokazywać wykres
        chart.delegate = self
        DataBuffor().start() //wygenrowanie statystyk
        showChart() //pojawienie się wykresu/aktualizacja wykresu
        //pickerView Do usuniecia
        
    }
    @IBAction func buttonDay(_ sender: UIButton) { //przycisk "Dzień"
        MyVariables.state = "Day" // przekazanie co ma pokazywać wykres
        DataBuffor().start() //wygenrowanie statystyk
        showChart() //pojawienie się wykresu/aktualizacja wykresu
        
        
        pickerDay.isHidden = false //picker widoczny DNI
        pickerMonth.isHidden = true //picker niewidoczny MIESIĄCE
        pickerYear.isHidden = true //picker niewidoczny LATA
        
        chart.titleForX = "Godzina"
    }
    @IBAction func buttonMonth(_ sender: UIButton) { //przycisk "Miesiąc"
        MyVariables.state = "Month" // przekazanie co ma pokazywać wykres
        DataBuffor().start() //wygenrowanie statystyk
        showChart() //pojawienie się wykresu/aktualizacja wykresu
        pickerData = months
        pickerMonth.delegate = self
        pickerMonth.dataSource = self
        
        pickerMonth.isHidden = false
        pickerDay.isHidden = true
        pickerYear.isHidden = true
        
        chart.titleForX = "Dzień"
        
    }
    @IBAction func buttonYear(_ sender: UIButton) { //przycisk "Rok"
        MyVariables.state = "Year" // przekazanie co ma pokazywać wykres
        DataBuffor().start() //wygenrowanie statystyk
        showChart() //pojawienie się wykresu/aktualizacja wykresu
        pickerData = year
        pickerYear.delegate = self
        pickerYear.dataSource = self
        
        pickerYear.isHidden = false
        pickerDay.isHidden = true
        pickerMonth.isHidden = true
        
        chart.titleForX = "Miesiąc"
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
    
    }
    //pickerView koniec usuniecia

    func showChart() {
    
    chart.collectionLines = []
    let line2 = APChartLine(chartView: chart, title: "max", lineWidth: 2.0, lineColor: UIColor.green)
    let line = APChartLine(chartView: chart, title: "prova", lineWidth: 2.0, lineColor: UIColor.purple)
     
    //add points to this line:
        switch MyVariables.state {
        case "Day":
            for i in 0...23{
                for i in 0...3{
                    
                }
                Control.powerUseH[i] = MyVariables.room1[i,0] + MyVariables.room2[i,0] + MyVariables.room3[i,0] + MyVariables.room4[i,0] + MyVariables.room5[i,0] + MyVariables.room2[i,0]
                line.addPoint( CGPoint(x: czas[i], y: moc1[i]))
                //line2.addPoint( CGPoint(x: czas[i], y: moc1[i]+10))
               

                
            }
        case "Month":
                for i in 0...29{ //ok
                    for j in 0...23{
                        for k in 0...6{ //k to dzien tygodnia
                    Stats.tableStats[i] += MyVariables.room1[j,k] + MyVariables.room2[j,k] + MyVariables.room3[j,k] + MyVariables.room4[j,k] + MyVariables.room5[j,k] + MyVariables.room6[j,k]
                            print("Dzień:",i+1,"",Stats.tableStats[i])
                        }
                    }
                     //print("Miesiac \(i) \(Stats.tableStats[i])")
//                    if i < 5 {
//                        let number = [300.0 ,400.0 ,500.0 , 600.0, 700.0 , 800.0, 900.0]
//                        let random = number.randomElement()!
//                        Stats.tableStats[i] += random
//                    }
                }
            //7 dni tygodnia
            for i in 0...29{
                print("Numer: ",i," ",Stats.tableStats[i])
                line.addPoint( CGPoint(x: monthX[i], y: Stats.tableStats[i]))
                //line2.addPoint( CGPoint(x: czas[i], y: moc1[i]+10))
            }
            
        case "Year":
            for i in 0...11{
                
                line.addPoint( CGPoint(x: rokX[i], y: rokYzuzycie[i]))
                //line2.addPoint( CGPoint(x: czas[i], y: moc1[i]+10))
                
            }
        default:
            print("Error")
        }
   
    // and add the line to the chart:
    chart.addLine(line)
    //chart.addLine(line2)
    
        
    //self.chart.addMarkerLine("x marker", x: 5 )
    //self.chart.addMarkerLine("y marker", y: 120.0 )
     
    chart.setNeedsDisplay()
    }
    
    
    func didSelectNearDataPoint(_ selectedDots: [String : APChartPoint]) {
        var txt = ""
        for (title,value) in selectedDots {
            txt = "\(txt)\(title): \(value.dot)\n"
        }
        //labelMomentPowerUse.text = "\(String(format: "%.0f", Double(tab[0]))) kWh"
        //labelFuturePowerUse.text = "\(String(format: "%.0f", Double(tab[1]))) kWh"
    }
    

}


extension Calendar {
    static let iso8601 = Calendar(identifier: .iso8601)
}

extension Date {
    var currentWeekMonday: Date {
        return Calendar.iso8601.date(from: Calendar.iso8601.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self))!
    }
}
