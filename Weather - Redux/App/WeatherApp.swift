//___FILEHEADER___

import SwiftUI

@main
struct Weather: App {
    
    private let store = AppStore(
        initialState: .init(searchedCity: .init()),
        reducer: appReducer,
        middlewares: [
            weatherMiddleware(service: CurrentWeatherRepository(apiKey: "599304f5bdc844899dec31a799dd6761")),
            loggerMiddleware()
        ]
    )
    
    init() {
        store.dispatch(.citySearch(.setSearchedValue(value: "")))
    }
        
    var body: some Scene {
        WindowGroup {
            SearchView()
                .environmentObject(store)
        }
    }
}
