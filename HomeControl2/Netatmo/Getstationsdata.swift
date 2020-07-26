//
//  Getstationsdata.swift
//  HomeControl
//
//  Created by Przemyslaw Kromólski on 11/05/2019.
//  Copyright © 2019 Przemyslaw Kromólski. All rights reserved.
//

import Foundation

struct Getstationsdata: Codable {
    let body: Body
    let status: String
    let timeExec: Double
    let timeServer: Int
    
    enum CodingKeys: String, CodingKey {
        case body, status
        case timeExec = "time_exec"
        case timeServer = "time_server"
    }
}

struct Body: Codable {
    let devices: [Device]
    let user: User
}

struct Device: Codable {
    let id, cipherID: String
    let dateSetup, lastSetup: Int
    let type: String
    let lastStatusStore: Int
    let moduleName: String
    let firmware, lastUpgrade, wifiStatus: Int
    let reachable, co2Calibrating: Bool
    let stationName: String
    let dataType: [String]
    let place: Place
    let dashboardData: DeviceDashboardData
    let modules: [Module]
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case cipherID = "cipher_id"
        case dateSetup = "date_setup"
        case lastSetup = "last_setup"
        case type
        case lastStatusStore = "last_status_store"
        case moduleName = "module_name"
        case firmware
        case lastUpgrade = "last_upgrade"
        case wifiStatus = "wifi_status"
        case reachable
        case co2Calibrating = "co2_calibrating"
        case stationName = "station_name"
        case dataType = "data_type"
        case place
        case dashboardData = "dashboard_data"
        case modules
    }
}

struct DeviceDashboardData: Codable {
    let timeUTC: Int
    let temperature: Double
    let co2, humidity, noise: Int
    let pressure, absolutePressure, minTemp, maxTemp: Double
    let dateMinTemp, dateMaxTemp: Int
    let tempTrend, pressureTrend: String
    
    enum CodingKeys: String, CodingKey {
        case timeUTC = "time_utc"
        case temperature = "Temperature"
        case co2 = "CO2"
        case humidity = "Humidity"
        case noise = "Noise"
        case pressure = "Pressure"
        case absolutePressure = "AbsolutePressure"
        case minTemp = "min_temp"
        case maxTemp = "max_temp"
        case dateMinTemp = "date_min_temp"
        case dateMaxTemp = "date_max_temp"
        case tempTrend = "temp_trend"
        case pressureTrend = "pressure_trend"
    }
}

struct Module: Codable {
    let id, type, moduleName: String
    let dataType: [String]
    let lastSetup: Int
    let reachable: Bool
    let dashboardData: ModuleDashboardData
    let firmware, lastMessage, lastSeen, rfStatus: Int
    let batteryVp, batteryPercent: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case type
        case moduleName = "module_name"
        case dataType = "data_type"
        case lastSetup = "last_setup"
        case reachable
        case dashboardData = "dashboard_data"
        case firmware
        case lastMessage = "last_message"
        case lastSeen = "last_seen"
        case rfStatus = "rf_status"
        case batteryVp = "battery_vp"
        case batteryPercent = "battery_percent"
    }
}

struct ModuleDashboardData: Codable {
    let timeUTC: Int
    let temperature: Double
    let humidity: Int
    let minTemp, maxTemp: Double
    let dateMinTemp, dateMaxTemp: Int
    let tempTrend: String
    
    enum CodingKeys: String, CodingKey {
        case timeUTC = "time_utc"
        case temperature = "Temperature"
        case humidity = "Humidity"
        case minTemp = "min_temp"
        case maxTemp = "max_temp"
        case dateMinTemp = "date_min_temp"
        case dateMaxTemp = "date_max_temp"
        case tempTrend = "temp_trend"
    }
}

struct Place: Codable {
    let altitude: Int
    let city, country, timezone: String
    let location: [Double]
}

struct User: Codable {
    let mail: String
    let administrative: Administrative
}

struct Administrative: Codable {
    let lang, regLocale, country: String
    let unit, windunit, pressureunit, feelLikeAlgo: Int
    
    enum CodingKeys: String, CodingKey {
        case lang
        case regLocale = "reg_locale"
        case country, unit, windunit, pressureunit
        case feelLikeAlgo = "feel_like_algo"
    }
}
