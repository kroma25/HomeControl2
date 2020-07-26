//
//  ModuleInSide.swift
//  HomeControl
//
//  Created by Przemyslaw Kromólski on 11/05/2019.
//  Copyright © 2019 Przemyslaw Kromólski. All rights reserved.
//

import UIKit

class ModuleInSide: UIViewController {
    
    @IBOutlet var wewTemperaturaLabel: UITextView!
    @IBOutlet var wewWilgotnoscLabel: UITextView!
    @IBOutlet var wewCO2Label: UITextView!
    @IBOutlet var wewGlosnoscLabel: UITextView!
    @IBOutlet var wewCisnienieLabel: UITextView!
    

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        AccessToken().getToken(scope: "read_station", userCompletionHandler:
            {
                token, error in
                if let token = token {
                    print("Token: ",token.accessToken)
                    self.wewTemp(tokenS: token.accessToken)
                }
        })
    }
    
    private func wewTemp(tokenS:String)//dane pogodowe
    {
        //string pozniej aby zobaczy w Safri jak to wyglada
        //https://api.netatmo.com/api/getstationsdata?access_token=5c96cff8e98f0d0b008b51fe|add86e8aa0a80f627d5b5d55a94c3cf7
        let parameters: [String: Any] = ["access_token": tokenS]
        let url = URL(string: "https://api.netatmo.com/api/getstationsdata")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = parameters.percentEscaped().data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request)
        {
            (data, response, error) in
            if let error = error
            {
                print("error: \(error)")
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
                }
                //Dekodowanie przez JSONSerialization
                /*
                 if let jsonObj = try? JSONSerialization.jsonObject(with: data, options: [])
                 {
                 //print(jsonObj,"\n")
                 
                 }
                 */
                //Dekodownie jsona przez JSONDecoder
                do {
                    let dane = try JSONDecoder().decode(Getstationsdata.self, from: data)
                    
                    //To pozniej do sprawdzenia typu
                    //print(type(of:test.body.devices.count))
                    //print(dane.body.devices[0].dashboardData.temperature)
                    //to ponizej jesli chce uzyc lablea w tym miejscu
                    DispatchQueue.main.async { // Correct
                        self.wewTemperaturaLabel.text = "Temperatura: \(dane.body.devices[0].dashboardData.temperature)°C"
                        self.wewWilgotnoscLabel.text = "Wilgotność: \(dane.body.devices[0].dashboardData.humidity)%"
                        self.wewCO2Label.text = "CO₂: \(dane.body.devices[0].dashboardData.co2) ppm"
                        self.wewGlosnoscLabel.text = "Głośność: \(dane.body.devices[0].dashboardData.noise) dB"
                        self.wewCisnienieLabel.text = "Ciśnienie: \(dane.body.devices[0].dashboardData.pressure) mbar"
                    }
                    
                } catch {
                    print("error: \(error)")
                }
            }
        }
        task.resume()
    }
}

