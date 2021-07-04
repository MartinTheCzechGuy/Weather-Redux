//
//  CityDetailView.swift
//  Weather - Redux
//
//  Created by Martin on 27.06.2021.
//

import SwiftUI

struct CityDetailView: View {
    
    private let background: LinearGradient
    private let iconName: String
    private let description: String
    private let temperature: Double
    private let pressure: Double
    private let humidity: Double
    private let city: String
    
    init(
        background: LinearGradient,
        iconName: String,
        description: String,
        temperature: Double,
        pressure: Double,
        humidity: Double,
        city: String
    ) {
        self.background = background
        self.iconName = iconName
        self.description = description
        self.temperature = temperature
        self.pressure = pressure
        self.humidity = humidity
        self.city = city
    }

    var body: some View {
        ZStack {
            background.ignoresSafeArea()
            
            VStack(
                alignment: .center,
                spacing: 20
            ) {
                Image(systemName: iconName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                                
                VStack {
                    Text(description)
                    Text("🌡 Temperature - \(String(format: "%.1f", temperature)) ℃")
                    Text("Pressure - \(String(format: "%.1f", pressure)) mb")
                    Text("💧 Humidity - \(String(format: "%.1f", humidity)) %")
                }
                .font(.title3)
            }
            .navigationTitle("Weather in \(city)")
        }
    }
}

struct CityDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CityDetailView(
            background: LinearGradient(
                gradient: Gradient(
                    colors: [
                        Color(red: 0.6544341662, green: 0.9271220419, blue: 0.9764705896, opacity: 1),
                        Color(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, opacity: 1)
                    ]),
                startPoint: .top,
                endPoint: .bottom
            ),
            iconName: "sun.max.fill",
            description: "description description description description description description description description description description description description description description description",
            temperature: 20,
            pressure: 20,
            humidity: 20.0,
            city: "city name"
        )
    }
}
