//
//  Thermostat.swift
//  HomeControl
//
//  Created by Przemyslaw Kromólski on 11/05/2019.
//  Copyright © 2019 Przemyslaw Kromólski. All rights reserved.
//

import UIKit

class Thermostat: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource  {
    @IBOutlet var TemperaturaGrzejnikLabel: UITextView!
    @IBOutlet var TemperaturaTermostatLabel: UITextView!
    @IBOutlet var TemperaturaTermostatNowaLabel: UITextView!
    @IBOutlet var TemperaturaGrzejnikNowaLabel: UITextView!
    
    @IBOutlet weak var picker: UIPickerView!
    var pickerData: [String] = [String]()
    
    var token2:String=""
    override func viewDidLoad()
    {
        
        super.viewDidLoad()
        //print("jej!!!")
        //var tempNowa:Double
        //let string = String(format: "%.2f", temperatura.body.home.rooms[0].thermMeasuredTemperature)
        //print(String(temperatura.body.home.rooms[0].thermMeasuredTemperature))
        //print(string)
        
        //pickerView Do usuniecia
        picker.delegate = self
        picker.dataSource = self
    
        pickerData = ["Pomieszczenie nr 1", "Pomieszczenie nr 2", "Pomieszczenie nr 3","Pomieszczenie nr 4", "Pomieszczenie nr 5","Pomieszczenie nr 6"]
        //pickerView koniec usuniecia
        AccessToken().getToken(scope: "read_thermostat", userCompletionHandler:
            {
                token, error in
                if let token = token {
                    print("Token: ",token.accessToken)
                    self.readThermostat(tokenS: token.accessToken)
                    
                }
        })
        AccessToken().getToken(scope: "write_thermostat", userCompletionHandler:
            {
                token, error in
                if let token = token {
                    print("Token: ",token.accessToken)                    
                    self.token2 = token.accessToken
                }
        })
        
    }//koniec override
    
    
    
    //https://medium.com/ios-os-x-development/build-an-stopwatch-with-swift-3-0-c7040818a10f  - timer
    //https://www.youtube.com/watch?v=EO-RjPik9p0  - timer
    
    var seconds = 0 //This variable will hold a starting value of seconds. It could be any amount above 0.
    var seconds2 = 0
    var timer = Timer()
    var timerValve = Timer()
    var isTimerRunning = false //This will be used to make sure only one timer is created at a time.
    var isTimerRunningValve = false
    func runTimerThermostat() //stoper termostatu
    {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(Thermostat.updateTimer)), userInfo: nil, repeats: true)
        isTimerRunning = true
    }
    func runTimerValve() //stoper głowicy termostatycznej
    {
        timerValve = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(Thermostat.updateTimerValve)), userInfo: nil, repeats: true)
        isTimerRunningValve = true
    }
    
    @objc func updateTimer() {
        seconds += 1     //This will decrement(count down)the seconds.
        print("Termostat: ",seconds)
        if seconds == 5 {
            timer.invalidate()
            seconds = 0
            isTimerRunning = false
            writeThermostat(tokenS: token2, roomId: "2451656302", temp: TemperaturaTermostatNowaLabel.text)
        }
    }
    @objc func updateTimerValve() {
        seconds2 += 1     //This will decrement(count down)the seconds.
        print("Głowica: ",seconds2)
        if seconds2 == 5 {
            timerValve.invalidate()
            seconds2 = 0
            isTimerRunningValve = false
            writeThermostat(tokenS: token2, roomId: "3427693877", temp: TemperaturaGrzejnikNowaLabel.text)
        }
    }
    @IBAction func plusTempTermostatButton(_ sender: Any) {
        seconds = 0
        if isTimerRunning == false {
            runTimerThermostat()
        }
        
        
        if var tempa = Double(TemperaturaTermostatNowaLabel.text!){
            tempa = tempa.round(nearest: 0.5)
            //print("The user entered a value price of \(tempa)")
            if tempa < 30{ // zabezpieczenie przed przekręceniem temperatury
                tempa+=0.5
                TemperaturaTermostatNowaLabel.text = String(tempa)
            }
            
        } else {
            print("Not a valid number: \(TemperaturaTermostatNowaLabel.text!)")
        }
        
    }
    @IBAction func minusTempTermostatButton(_ sender: Any) {
        seconds = 0
        if isTimerRunning == false {
            runTimerThermostat()
        }
        
        if var tempa = Double(TemperaturaTermostatNowaLabel.text!){
            tempa = tempa.round(nearest: 0.5)
            //print("Ustawiona temperatura: \(tempa)")
            if tempa > 7 { // zabezpieczenie przed przekręceniem temperatury
                tempa-=0.5
                TemperaturaTermostatNowaLabel.text = String(tempa)
            }
            
        } else {
            print("Not a valid number: \(TemperaturaTermostatNowaLabel.text!)")
        }
    }
    @IBAction func plusTempGrzejnikButton(_ sender: Any) {
        if MyVariables.statePickerValve == "Pomieszczenie nr 1"{
        seconds2 = 0
        if isTimerRunningValve == false {
            runTimerValve()
        }
        }
        
        if var tempa = Double(TemperaturaGrzejnikNowaLabel.text!){
            tempa = tempa.round(nearest: 0.5)
            //print("The user entered a value price of \(tempa)")
            if tempa < 30{ // zabezpieczenie przed przekręceniem temperatury
                tempa+=0.5
                TemperaturaGrzejnikNowaLabel.text = String(tempa)
            }
            
        } else {
            print("Not a valid number: \(TemperaturaGrzejnikNowaLabel.text!)")
        }

        let currentValue = Double(TemperaturaGrzejnikNowaLabel.text!)
        MyVariables.valveChange["\(MyVariables.statePickerValve)"] = currentValue

        
    }
    @IBAction func minusTempGrzejnikButton(_ sender: Any) {
        if MyVariables.statePickerValve == "Pomieszczenie nr 1"{
        seconds2 = 0
        if isTimerRunningValve == false {
            runTimerValve()
        }
        }
        if var tempa = Double(TemperaturaGrzejnikNowaLabel.text!){
            tempa = tempa.round(nearest: 0.5)
            //print("Ustawiona temperatura: \(tempa)")
            if tempa > 7 { // zabezpieczenie przed przekręceniem temperatury
                tempa-=0.5
                TemperaturaGrzejnikNowaLabel.text = String(tempa)
            }
            
        } else {
            print("Not a valid number: \(TemperaturaGrzejnikNowaLabel.text!)")
        }
        
        let currentValue = Double(TemperaturaGrzejnikNowaLabel.text!)
        MyVariables.valveChange["\(MyVariables.statePickerValve)"] = currentValue
        
        
    }

    
    func readThermostat(tokenS:String)  {
        let parameters: [String: Any] = ["access_token": tokenS,
                                         "home_id": "5c9cfaeaeefeb715008cd14a"]
        let url = URL(string: "https://api.netatmo.com/api/homestatus")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = parameters.percentEscaped().data(using: .utf8)
        
        
        
        let task = URLSession.shared.dataTask(with: request)
        {
            (data, response, error) in
            if let error = error
            {
                print("error podczas odbioru: \(error)")
            }
            else
            {
                guard let data = data else {
                    print("Error: No data to decode")
                    return
                }
                
                if let response = response as? HTTPURLResponse
                {
                    print("statusCode: \(response.statusCode)")
                    print("DATA: ",data)
                    print("Response: ",response)
                    
                }
            do {
                let temperatura = try JSONDecoder().decode(ReadThermostatClass.ReadThermostat.self, from: data)
                //print(temperatura)
                DispatchQueue.main.async { // Correct
                    self.TemperaturaGrzejnikLabel.text = "\(String(temperatura.body.home.rooms[1].thermMeasuredTemperature))°C"
                    self.TemperaturaTermostatLabel.text = "\(String(temperatura.body.home.rooms[0].thermMeasuredTemperature))°C"
                    self.TemperaturaTermostatNowaLabel.text = String(temperatura.body.home.rooms[0].thermSetpointTemperature)
                    self.TemperaturaGrzejnikNowaLabel.text = String(temperatura.body.home.rooms[1].thermSetpointTemperature)
                    MyVariables.valve["Pomieszczenie nr 1"] = Double(temperatura.body.home.rooms[1].thermMeasuredTemperature)
                }
                
                
            } catch {
                print("error podczas odczytu konwersji: \(error)")
                }
            }
        }
        task.resume()
}

    //#########
    
    func writeThermostat(tokenS:String,roomId:String,temp:String){
        print("zmieniamy temperatury: ",TemperaturaTermostatNowaLabel.text as Any)
        
        let parameters: [String: Any] = ["access_token": tokenS,
                                         "home_id": "5c9cfaeaeefeb715008cd14a",
                                         "room_id": roomId,
                                         "mode": "manual",
                                         "temp": temp,
                                         /*"endtime": "1557744675",*/ ] //https://www.epochconverter.com/ czas lokalny mozna usunac wtedy 1h jest
        
        let url = URL(string: "https://api.netatmo.com/api/setroomthermpoint")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = parameters.percentEscaped().data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("error podczas wysłania temp: \(error)")
            } else {
                if let response = response as? HTTPURLResponse {
                    print("statusCode: \(response.statusCode)")
                }
                if let data = data, let dataString = String(data: data, encoding: .utf8) {
                    print("data: \(dataString)")
                    
                }
            }
        }
        task.resume()
        
        
        
        
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
        
        TemperaturaGrzejnikNowaLabel.text = String(describing: MyVariables.valveChange[pickerData[row]] ?? 0)
        TemperaturaGrzejnikLabel.text = "\(String(describing: MyVariables.valve[pickerData[row]] ?? 0))°C"
        MyVariables.statePickerValve = "\(pickerData[row])"
        // tutaj zmienamy wyglad statystk
        
    }
    //pickerView koniec usuniecia
}//koniec klasy


//zaokraglanie :D
//https://stackoverflow.com/questions/34460823/round-double-to-0-5
extension Double {
    func round(nearest: Double) -> Double {
        let n = 1/nearest
        let numberToRound = self * n
        return numberToRound.rounded() / n
    }
    
    func floor(nearest: Double) -> Double {
        let intDiv = Double(Int(self / nearest))
        return intDiv * nearest
    }
}
