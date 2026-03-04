//
//  WeatherIconMapper.swift
//  Weather
//
//  Created by Tabirca Nicolae-Eduard on 05.03.2026.
//

import Foundation

func iconName(for weatherID: Int, isNight: Bool) -> String {

    switch weatherID {

    case 200...232:
        return isNight ? "StormIcon" : "StormWithSunIcon"

    case 300...321:
        return isNight ? "DrizzleNightIcon" : "DrizzleDayIcon"

    case 500...531:
        return "RainIcon"

    case 600...622:
        return "SnowIcon"

    case 701...781:
        return "FogIcon"

    case 800:
        return isNight ? "MoonIcon" : "SunIcon"

    case 801...804:
        return isNight ? "PartiallyNightIcon" : "PartiallyDayIcon"

    default:
        return "CloudIcon"
    }
}

func isNightTime(current: Int, sunrise: Int, sunset: Int) -> Bool {
    return current < sunrise || current > sunset
}

func seasonString() -> String {
    let month = Calendar.current.component(.month, from: Date())

    switch month {
    case 3...5: return "Spring"
    case 6...8: return "Summer"
    case 9...11: return "Autumn"
    default: return "Winter"
    }
}

func timeOfDay(current: Int, sunrise: Int, sunset: Int) -> String {

    if current < sunrise {
        return "Night"
    }

    let dayLength = sunset - sunrise
    let noon = sunrise + dayLength / 2
    let eveningStart = sunset - dayLength / 4

    if current < noon {
        return "Morning"
    } else if current < eveningStart {
        return "Afternoon"
    } else if current < sunset {
        return "Evening"
    } else {
        return "Night"
    }
}

func seasonIcon() -> String {
    let month = Calendar.current.component(.month, from: Date())

    switch month {
    case 3...5:
        return "SpringIcon"
    case 6...8:
        return "SummerIcon"
    case 9...11:
        return "AutumnIcon"
    default:
        return "WinterIcon"
    }
}
