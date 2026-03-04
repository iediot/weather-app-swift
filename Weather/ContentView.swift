//
//  ContentView.swift
//  Weather
//
//  Created by Tabirca Nicolae-Eduard on 04.03.2026.
//

import SwiftUI

struct ContentView: View {

    @State private var city = ""
    @State private var weather: WeatherResponse?
    
    func searchWeather() {
        Task {
            do {
                let result = try await service.fetchWeather(city: city)

                withAnimation(.easeInOut(duration: 0.35)) {
                    weather = result
                }

                city = ""
            } catch {
                print(error)
            }
        }
    }
    
    var searchBar: some View {
        HStack {

            Image(systemName: "magnifyingglass")
                .foregroundColor(.white.opacity(0.7))

            TextField("", text: $city,
                prompt: Text("Search city").foregroundColor(.white.opacity(0.7)))
                .foregroundColor(.white)
                .onSubmit {
                    searchWeather()
                }

            Button {
                searchWeather()
            } label: {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.white)
                    .font(.system(size: 20))
            }
        }
        .padding(.horizontal)
        .frame(height: 44)
        .background(.ultraThinMaterial)
        .cornerRadius(14)
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(.white.opacity(0.2))
        )
        .shadow(color: .black.opacity(0.2), radius: 8, y: 4)
        .padding(.horizontal)
    }

    let service = WeatherService()

    var body: some View {

        ZStack {

            LinearGradient(
                colors: [.blue, .cyan],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            .task {
                do {
                    weather = try await service.fetchWeather(city: "London")
                } catch {
                    print(error)
                }
            }
            
            VStack(spacing: 25) {
                
                searchBar
                .padding(.horizontal)
                .padding(.bottom)
                
                if let weather = weather {

                    let night = isNightTime(
                        current: Int(Date().timeIntervalSince1970),
                        sunrise: weather.sys.sunrise,
                        sunset: weather.sys.sunset
                    )

                    let icon = iconName(
                        for: weather.weather.first?.id ?? 800,
                        isNight: night
                    )

                    let season = seasonIcon()

                    Image(icon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 140)

                    Text(weather.name)
                        .font(.system(size: 40, weight: .medium))
                        .foregroundColor(.white)

                    Text("\(weather.main.temp, specifier: "%.1f")°")
                        .font(.system(size: 70, weight: .thin))
                        .foregroundColor(.white)

                    Text(weather.weather.first?.description.capitalized ?? "")
                        .font(.title3)
                        .foregroundColor(.white.opacity(0.8))

                    Spacer()

                    HStack {

                        HStack(spacing: 6) {
                            Image(seasonIcon())
                                .resizable()
                                .scaledToFit()
                                .frame(width: 28, height: 28)

                            Text(seasonString())
                                .font(.headline)
                                .foregroundColor(.white.opacity(0.8))
                        }

                        Spacer()

                        HStack(spacing: 6) {

                            Image(night ? "NightIcon" : "DayIcon")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)

                            Text(night ? "Night" : "Day")
                                .font(.headline)
                                .foregroundColor(.white.opacity(0.8))
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                }
            }
        }.onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                            to: nil,
                                            from: nil,
                                            for: nil)
        }
    }
}

#Preview {
    ContentView()
}
