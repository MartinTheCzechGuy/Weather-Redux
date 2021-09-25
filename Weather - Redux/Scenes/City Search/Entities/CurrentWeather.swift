//
//  CurrentWeather.swift
//  Weather - Redux
//
//  Created by Martin on 26.06.2021.
//

import Foundation

struct CurrentWeather: Identifiable {
    let id = UUID()
    let city: String
    let weather: WeatherCode
    let description: String
    let temperature: Double
    let pressure: Double
    let humidity: Double
}

extension CurrentWeather: Hashable {}
