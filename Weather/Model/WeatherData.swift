//
//  WeatherData.swift
//  Weather
//
//  Created by Tabirca Nicolae-Eduard on 04.03.2026.
//

struct Sys: Codable {
    let sunrise: Int
    let sunset: Int
}

struct WeatherResponse: Codable {
    let weather: [Weather]
    let main: Main
    let name: String
    let sys: Sys
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
}
