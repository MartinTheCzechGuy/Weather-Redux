//
//  WeatherError.swift
//  Weather - Redux
//
//  Created by Martin on 26.06.2021.
//

enum WeatherError: Error {
    case cityNotFound
    case unknownError
    case buildingRequestFailure
    case decodingError
}
