//
//  CitySearchActions.swift
//  Weather - Redux
//
//  Created by Martin on 26.06.2021.
//

struct UpdateSearchedText: BindingUpdateAction {
    let state: String
}

struct SetSearchResult: BindingUpdateAction {
    let state: [CurrentWeather]
}

struct SetError: BindingUpdateAction {
    let state: Bool
}

struct StartLoading: Action {}
