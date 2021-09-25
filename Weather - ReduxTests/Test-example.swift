//___FILEHEADER___

import XCTest

@testable import Weather___Redux

class ___FILEBASENAMEASIDENTIFIER___: XCTestCase {
    func testExample() {
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
}
