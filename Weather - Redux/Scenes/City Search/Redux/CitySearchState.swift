//
//  CitySearchState.swift
//  Weather - Redux
//
//  Created by Martin on 26.06.2021.
//

import Foundation

struct CitySearchState {
    var searchedCity = ""
    var results = [CurrentWeather]()
    var isLoading = false
    var isShowingError = false
}
