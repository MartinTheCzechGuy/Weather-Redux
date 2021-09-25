//
//  SearchView.swift
//  Weather - Redux
//
//  Created by Martin on 26.06.2021.
//

import Combine
import UIKit
import SwiftUI

struct SearchView: View {
    
    @EnvironmentObject var store: AppStore
    
    init() {
        UITableView.appearance().backgroundColor = .none
    }
    
    var body: some View {
        let searchedCity: Binding<String> = .init(
            get: { store.state.searchedCity.searchedCity },
            set: { store.dispatch(.citySearch(.setSearchedValue(value: $0))) }
        )
        
        let showingError: Binding<Bool> = .init(
            get: { store.state.searchedCity.isShowingError },
            set: { store.dispatch(.citySearch(.showError($0))) }
        )
        
        if store.state.searchedCity.isLoading {
            ProgressView(label: { Text("Loading data...") })
        } else {
            NavigationView {
                VStack {
                    HStack {
                        TextField("Enter city name...", text: searchedCity)
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
                                store.dispatch(.citySearch(.startLoading))
                                store.dispatch(.citySearch(.fetchWeather))
                            },
                            label: { Image(systemName: "magnifyingglass") }
                        )
                    }
                    
                    if (!store.state.searchedCity.results.isEmpty) {
                        HStack {
                            VStack { Divider().background(Color.black) }.padding(10)
                            Text("Results").foregroundColor(.black)
                            VStack { Divider().background(Color.black) }.padding(10)
                        }
                        .padding()
                    }
                    
                    List {
                        ForEach(store.state.searchedCity.results) { weather in
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
                                }
                            )
                            .padding()
                        }
                        .border(Color.gray)
                        .listRowInsets(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                    }
                }
                .alert(isPresented: showingError) { () -> Alert in
                    Alert(
                        title: Text("The city name \(store.state.searchedCity.searchedCity) not found. Please try a different search."),
                        dismissButton: .default(Text("OK"), action: { store.dispatch(.citySearch(.showError(false))) })
                    )
                }
                .navigationTitle("Search")
                .navigationViewStyle(StackNavigationViewStyle())
                .padding()
            }
        }
    }
}

