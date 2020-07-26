//
//  AccessToken.swift
//  HomeControl
//
//  Created by Przemyslaw Kromólski on 11/05/2019.
//  Copyright © 2019 Przemyslaw Kromólski. All rights reserved.
//

import Foundation

class AccessToken
{
    struct Token: Codable {
        let accessToken, refreshToken: String
        let scope: [String]
        let expiresIn, expireIn: Int
        
        enum CodingKeys: String, CodingKey {
            case accessToken = "access_token"
            case refreshToken = "refresh_token"
            case scope
            case expiresIn = "expires_in"
            case expireIn = "expire_in"
        }
    }
    
    func getToken(scope:String,userCompletionHandler: @escaping (Token?, Error?) -> Void) {
        let parameters: [String: Any] = ["grant_type": "password",
                                         "username": "kromek25@gmail.com",
                                         "password": "1jS@XA68yw%rn1M",
                                         "client_id":"5c96d119e98f0dca798db4eb",
                                         "client_secret": "9yBzbRTwG9qLe9UQNIUNF8EWc6LR0T",
                                         "scope": scope]
        let url = URL(string: "https://api.netatmo.com/oauth2/token")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = parameters.percentEscaped().data(using: .utf8)
        
        
        
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            
            guard let data = data else { return }
            do {
                // parse json data and return it
                
                let token = try JSONDecoder().decode(Token.self, from: data)
                
                if let userData:Token = token {
                    userCompletionHandler(userData, nil)
                }
                
            } catch let parseErr {
                print("JSON Parsing Error", parseErr)
                userCompletionHandler(nil, parseErr)
            }
        })
        
        task.resume()
    }
}
