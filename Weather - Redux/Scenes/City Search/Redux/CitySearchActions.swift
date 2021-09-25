//
//  CitySearchActions.swift
//  Weather - Redux
//
//  Created by Martin on 26.06.2021.
//

enum CitySearchAction {
    case fetchWeather
    case setSearchedValue(value: String)
    case setWeatherResult(_ weather: [CurrentWeather])
    case startLoading
    case showError(Bool)
}
