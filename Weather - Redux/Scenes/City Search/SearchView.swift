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
        VStack {
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Enter city name...", text: $store.state.searchedCity)
                    .onChange(of: store.state.$searchedCity, perform: { value in
                        store.dispatch(searchCity)
                    })
            }
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
            .shadow(color: .gray, radius: 10)
            
            if (!store.state.results.isEmpty) {
                HStack {
                    VStack { Divider().background(Color.black) }.padding(10)
                    Text("Results").foregroundColor(.black)
                    VStack { Divider().background(Color.black) }.padding(10)
                }
                .padding()
            }
            
            List(store.state.results, id: \.self) { weather in
                Text(weather.city)
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
    }
    
    var searchCity: Thunk<CitySearchStore> {
        Thunk<CitySearchStore> { dispatch, getState in
            let state = getState()
            
            print("ADAMUS - time \(state.lastCharacterEntered)")
            print("ADAMUS - mesto \(state.searchedCity)")
            
            guard let time = state.lastCharacterEntered, time.timeIntervalSinceNow > 1 else {
                print("je to min jak vterina")
                return
            }
            
            print("Je to vic jak vterina")
//            if aaaa.timeIntervalSinceNow > 1 {
//
//                repository.currentWeather(for: state.searchedCity) { result in
//                    print("received new value \(result)")
//                    switch result {
//                    case .success(let weather):
//                        dispatch(SetSearchResult(state: [weather]))
//                    case .failure(_):
//                        dispatch(SetError(state: true))
//                    }
//                }
//            } else {
//                print("je to min jak vterina")
//            }
        }
    }
}

