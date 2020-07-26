//
//  ReadThermostat.swift
//  HomeControl
//
//  Created by Przemyslaw Kromólski on 11/05/2019.
//  Copyright © 2019 Przemyslaw Kromólski. All rights reserved.
//

import Foundation

class ReadThermostatClass {
struct ReadThermostat: Codable {
    let status: String
    let timeServer: Int
    let body: Body
    
    enum CodingKeys: String, CodingKey {
        case status
        case timeServer = "time_server"
        case body
    }
}

struct Body: Codable {
    let home: Home
}

struct Home: Codable {
    let modules: [Module]
    let rooms: [Room]
    let id: String
}

struct Module: Codable {
    let id, type: String
    let firmwareRevision, rfStrength: Int
    let wifiStrength: Int?
    let reachable: Bool?
    let batteryLevel: Int?
    let boilerValveComfortBoost, boilerStatus, anticipating: Bool?
    let bridge, batteryState: String?
    
    enum CodingKeys: String, CodingKey {
        case id, type
        case firmwareRevision = "firmware_revision"
        case rfStrength = "rf_strength"
        case wifiStrength = "wifi_strength"
        case reachable
        case batteryLevel = "battery_level"
        case boilerValveComfortBoost = "boiler_valve_comfort_boost"
        case boilerStatus = "boiler_status"
        case anticipating, bridge
        case batteryState = "battery_state"
    }
}

struct Room: Codable {
    let id: String
    let reachable: Bool
    let thermMeasuredTemperature: Double
    let thermSetpointTemperature: Double
    let thermSetpointMode: String
    let thermSetpointStartTime, thermSetpointEndTime: Int
    let anticipating, openWindow: Bool
    let heatingPowerRequest: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, reachable
        case thermMeasuredTemperature = "therm_measured_temperature"
        case thermSetpointTemperature = "therm_setpoint_temperature"
        case thermSetpointMode = "therm_setpoint_mode"
        case thermSetpointStartTime = "therm_setpoint_start_time"
        case thermSetpointEndTime = "therm_setpoint_end_time"
        case anticipating
        case openWindow = "open_window"
        case heatingPowerRequest = "heating_power_request"
    }
}
}
