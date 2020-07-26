//
//  ModuleOutSide.swift
//  HomeControl
//
//  Created by Przemyslaw Kromólski on 04/05/2019.
//  Copyright © 2019 Przemyslaw Kromólski. All rights reserved.
//

import UIKit

class ModuleOutSide: UIViewController {
    

    @IBOutlet var zewTempLabel: UITextView!
    @IBOutlet var zewWilgLabel: UITextView!
    @IBOutlet var zewCisnLabel: UITextView!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

       
        AccessToken().getToken(scope: "read_station", userCompletionHandler:
            {
                token, error in
                if let token = token {
                    print("Token: ",token.accessToken)
                    self.zewTemp(tokenS: token.accessToken)
                }
        })

    }
    
    private func zewTemp(tokenS:String)//dane pogodowe
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
              
                do {
                    let dane = try JSONDecoder().decode(Getstationsdata.self, from: data)
                    
                    //to ponizej jesli chce uzyc lablea w tym miejscu
                    DispatchQueue.main.async { // Correct
                        self.zewTempLabel.text = "Temperatura: \(dane.body.devices[0].modules[0].dashboardData.temperature)°C"
                        self.zewWilgLabel.text = "Wilgotność: \(dane.body.devices[0].modules[0].dashboardData.humidity)%"
                        self.zewCisnLabel.text = "Ciśnienie: \(dane.body.devices[0].dashboardData.pressure) mbar"
                        
                    }

                } catch {
                    print("error: \(error)")
                }
            }
        }
        task.resume()
}
}
//#########

