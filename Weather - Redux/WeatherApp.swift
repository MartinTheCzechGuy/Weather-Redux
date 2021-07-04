//___FILEHEADER___

import SwiftUI

@main
struct Weather: App {
    
    @StateObject var store = CitySearchStore.createStore(
        reducer: CitySearchReducer.self,
        preloadedState: nil,
        enhancer: CitySearchStore.applyMiddleware(middlewares: [
            ThunkMiddleware<CitySearchStore>.middleware
        ])
    )
    .initialize()
    
    var body: some Scene {
        WindowGroup {
            SearchView(repository: CurrentWeatherRepositoryMock())
                .environmentObject(store)
        }
    }
}
