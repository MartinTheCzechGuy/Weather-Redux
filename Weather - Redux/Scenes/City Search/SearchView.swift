//
//  SearchView.swift
//  Weather - Redux
//
//  Created by Martin on 26.06.2021.
//

import Combine
import SwiftUI

struct SearchView: View {
    
    @EnvironmentObject var store: CitySearchStore
    private let repository: CurrentWeatherRepositoryType
    
    init(repository: CurrentWeatherRepositoryType) {
        self.repository = repository
    }
    
    var body: some View {
        if store.state.showLoading {
            ProgressView(label: { Text("Loading data...") })
        } else {
            NavigationView {
                VStack {
                    HStack {
                        TextField("Enter city name...", text: $store.state.searchedCity)
                            .padding(10)
                            .background(
                                LinearGradient(
                                    gradient: Gradient(
                                        colors: [
                                            Color(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, opacity: 1)
                                        ]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .cornerRadius(20)

                        Button(
                            action: {
                                store.dispatch(StartLoading())
                                store.dispatch(searchCity)
                            },
                            label: { Image(systemName: "magnifyingglass") }
                        )
                    }
                                
                    if (!store.state.results.isEmpty) {
                        HStack {
                            VStack { Divider().background(Color.black) }.padding(10)
                            Text("Results").foregroundColor(.black)
                            VStack { Divider().background(Color.black) }.padding(10)
                        }
                        .padding()
                    }

                    List(store.state.results, id: \.self) { weather in
                        NavigationLink(
                            destination: CityDetailView(
                                background: weather.weather.background,
                                iconName: weather.weather.iconName,
                                description: weather.description,
                                temperature: weather.temperature,
                                pressure: weather.pressure,
                                humidity: weather.humidity,
                                city: weather.city
                            ),
                            label: {
                                Text(weather.city)
                            })
                    }
                    .listRowInsets(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                }
                .padding()
                .alert(isPresented: $store.state.showError) { () -> Alert in
                    Alert(
                        title: Text("The city name \(store.state.searchedCity) not found. Please try a different search."),
                        dismissButton: .default(Text("OK"))
                    )
                }
                .navigationTitle("Search")
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
    
    var searchCity: Thunk<CitySearchStore> {
        Thunk<CitySearchStore> { dispatch, getState in
            let state = getState()
                        
            repository.currentWeather(for: state.searchedCity) { result in
                print("received new value \(result)")
                switch result {
                case .success(let weather):
                    dispatch(SetSearchResult(state: [weather]))
                case .failure(_):
                    dispatch(SetError(state: true))
                }
            }
        }
    }
}

