//
//  WeatherService.swift
//  Weather
//
//  Created by Tabirca Nicolae-Eduard on 04.03.2026.
//

import Foundation

class WeatherService {

    func fetchWeather(city: String) async throws -> WeatherResponse {

        let apiKey = "67ae9e7786ac27e8bbc5556485684a9d"
        let urlString =
        "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)&units=metric"

        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)

        print(String(data: data, encoding: .utf8)!)

        let decoded = try JSONDecoder().decode(WeatherResponse.self, from: data)

        return decoded
    }
}
