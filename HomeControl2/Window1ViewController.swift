//
//  Window1ViewController.swift
//  HomeControl2
//
//  Created by Przemyslaw Kromólski on 14/01/2019.
//  Copyright © 2019 Przemyslaw Kromólski. All rights reserved.
//

import UIKit

class Window1ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource  {
    
    @IBOutlet var picker: UIPickerView!
    @IBOutlet weak var redDot: UIImageView!
    @IBOutlet weak var greenDot: UIImageView!
    @IBOutlet var labelBrightnessLight: UITextView!
    @IBOutlet weak var sliderBrightnessLight: UISlider!
    
    var buttonOn1 = true
    var pickerData: [String] = [String]()
    //var selectedValue = pickerViewContent[pickerView.selectedRowInComponent(0)]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.delegate = self
        picker.dataSource = self
        pickerData = ["Pomieszczenie nr 1", "Pomieszczenie nr 2", "Pomieszczenie nr 3","Pomieszczenie nr 4", "Pomieszczenie nr 5","Pomieszczenie nr 6"]
        //Dane startowe
        sliderBrightnessLight.value = Float(MyVariables.brightness["Pomieszczenie nr 1"] ?? 0)
        let x:Int = MyVariables.brightness["Pomieszczenie nr 1"] ?? 0
        labelBrightnessLight.text  = "Natężenie: \(String(describing: x) as String) %"
        if sliderBrightnessLight.value == 0 {
            redDot.isHidden = false
            greenDot.isHidden = true
        }else
        {
            redDot.isHidden = true
            greenDot.isHidden = false
        }
    }
    
    var seconds = 0 //This variable will hold a starting value of seconds. It could be any amount above 0.
    var timer = Timer()
    var isTimerRunning = false //This will be used to make sure only one timer is created at a time.
    var level:Double = 0 // wstepna wartosc swiatla
    
    func runTimer()
    {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(Window1ViewController.updateTimer)), userInfo: nil, repeats: true)
        isTimerRunning = true
    }
    
    @objc func updateTimer() {
        level = MyVariables.levelLightings
        seconds += 1     //This will decrement(count down)the seconds.
        print(seconds)
        if seconds == 1 {
            timer.invalidate()
            seconds = 0
            isTimerRunning = false
            //obliczmay poziom natezenia
            
            dimmerBox(number: Int((level/100)*255))
            print("Wynik: \(Int((level/100)*255))")
        }
    }
    
    
    @IBAction func sliderBrightnessLight(_ sender: UISlider) {
        let currentValue = Int(sender.value)
        
        labelBrightnessLight.text = "Natężenie: \(currentValue) %"
        MyVariables.brightness["\(MyVariables.statePickerBrightness)"] = currentValue
        if MyVariables.statePickerBrightness == "Pomieszczenie nr 1"
        {
        //obsluga natezenia swiatla
        MyVariables.levelLightings = Double(currentValue)
        seconds = 0
        if isTimerRunning == false {
            runTimer()
        }
        }
        //###################
        if currentValue == 0 {
            redDot.isHidden = false
            greenDot.isHidden = true
        }else
        {
            redDot.isHidden = true
            greenDot.isHidden = false
        }
    }
    
    
    
    
  //przycisk od ledow
    @IBAction func Button2(_ sender: UIButton) {
        if buttonOn1 {
            if MyVariables.statePickerBrightness == "Pomieszczenie nr 1"
            {
            dimmerBox(number: 255)
            }
            //activeLed() //tylko przycski
            labelBrightnessLight.text = "Natężenie: \(100) %"
            MyVariables.brightness["\(MyVariables.statePickerBrightness)"] = 100
            sliderBrightnessLight.value = 100
            print("ON")
        } else {
            if MyVariables.statePickerBrightness == "Pomieszczenie nr 1"
            {
            dimmerBox(number: 0)
            }
            //inactiveLed()  //tylko przycski
            labelBrightnessLight.text = "Natężenie: \(0) %"
            MyVariables.brightness["\(MyVariables.statePickerBrightness)"] = 0
            sliderBrightnessLight.value = 0
            print("OFF")
        }
        buttonOn1 = !buttonOn1
        if sliderBrightnessLight.value == 0 {
            redDot.isHidden = false
            greenDot.isHidden = true
        }else
        {
            redDot.isHidden = true
            greenDot.isHidden = false
        }
    }
    //scroll

    
    
    //Wylaczenie Ledow
    func inactiveLed(){
        dimmerBox(number: 0)
        //button1.setTitle("Wyłącz", for: UIControl.State.normal)
        if let url = URL(string: "http://192.168.0.20/s/0") {
            do {
                let contents = try String(contentsOf: url)
                //print(contents) //informacje co jest odbierane
            } catch {
                // contents could not be loaded
            }
        } else {
            // the URL was bad!
        }
    }
    
    //Wlaczenie Ledow
    func activeLed() {
        dimmerBox(number: 255)
        //button1.setTitle("Włącz", for: UIControl.State.normal)
        if let url = URL(string: "http://192.168.0.20/s/1") {
            do {
                let contents = try String(contentsOf: url)
                //print(contents) //informacje co jest odbierane
            } catch {
                // contents could not be loaded
            }
        } else {
            // the URL was bad!
        }
    }
    
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
        //tutaj dane
        labelBrightnessLight.text = "Natężenie: \(String(describing: MyVariables.brightness[pickerData[row]] ?? 0)) %"
        MyVariables.statePickerBrightness = "\(pickerData[row])"
        //Zmiana wartości slidera podczas wyboru pickera
        sliderBrightnessLight.value = Float(MyVariables.brightness[pickerData[row]] ?? 0)
        if MyVariables.brightness[pickerData[row]] == 0 {
            redDot.isHidden = false
            greenDot.isHidden = true
        }else
        {
            redDot.isHidden = true
            greenDot.isHidden = false
        }
    }

    func dimmerBox(number:Int)  {
        // prepare json data
        let json: [String: Any] = [
            "dimmer": [
                "loadType": 2,
                "desiredBrightness": number,
                "overloaded": false,
                "overheated": false
            ]
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        // create post request
        let url = URL(string: "http://192.168.0.20/api/dimmer/set")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // insert json data to the request
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                //print(responseJSON) // drukuje odpowiedz
                print("Zmiana-Slider")
            }
        }
        task.resume()
        }
}



 
 
