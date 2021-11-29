import XCTest

@testable import Weather___Redux

class CitySearchReducerTests: XCTestCase {
    func test_setting_searched_value() {
        let sut = AppStore(
            initialState: .init(searchedCity: .init()),
            reducer: appReducer,
            middlewares: [
                weatherMiddleware(service: CurrentWeatherRepositoryMock()),
                loggerMiddleware()
            ]
        )
        
        let expectedValue = "S"
        
        sut.dispatch(.citySearch(.setSearchedValue(value: expectedValue)))
        
        XCTAssertEqual(expectedValue, sut.state.searchedCity.searchedCity)
    }
    
    func test_set_empty_search_result() {
        let sut = AppStore(
            initialState: .init(searchedCity: .init()),
            reducer: appReducer,
            middlewares: [
                weatherMiddleware(service: CurrentWeatherRepositoryMock()),
                loggerMiddleware()
            ]
        )
        
        let expectedValue = [CurrentWeather]()
        
        sut.dispatch(.citySearch(.setWeatherResult(expectedValue)))
        
        XCTAssertEqual(expectedValue, sut.state.searchedCity.results)
    }
    
    func test_set_weather_search_result() {
        let sut = AppStore(
            initialState: .init(searchedCity: .init()),
            reducer: appReducer,
            middlewares: [
                weatherMiddleware(service: CurrentWeatherRepositoryMock()),
                loggerMiddleware()
            ]
        )
        
        let expectedValue = [
            CurrentWeather(city: "random city", weather: .clear, description: "desc", temperature: 10, pressure: 20, humidity: 30)
        ]
        
        sut.dispatch(.citySearch(.setWeatherResult(expectedValue)))
        
        XCTAssertEqual(expectedValue, sut.state.searchedCity.results)
    }
}
