//
//  Middleware.swift
//  Weather - Redux
//
//  Created by Martin on 19.09.2021.
//

import Combine
import Foundation

typealias Middleware<State, Action> = (State, Action) -> AnyPublisher<Action, Never>

func weatherMiddleware(service: CurrentWeatherRepositoryType) -> Middleware<AppState, AppAction> {
    return { state, action in
        switch action {
        case .citySearch(.fetchWeather):
            return service.currentWeather(for: state.searchedCity.searchedCity)
                 .map { result in
                    switch result {
                    case .success(let weather):
                        return AppAction.citySearch(.setWeatherResult([weather]))
                    case .failure(_):
                        return AppAction.citySearch(.showError(true))
                    }
                }
                .eraseToAnyPublisher()
        default:
            return Empty().eraseToAnyPublisher()
        }
    }
}

func loggerMiddleware() -> Middleware<AppState, AppAction> {
    return { state, action in
        print("New action -> \(action)")
        return Empty().eraseToAnyPublisher()
    }
}
