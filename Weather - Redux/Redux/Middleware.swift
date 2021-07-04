//
//  Middleware.swift
//  Weather - Redux
//
//  Created by Martin on 26.06.2021.
//

protocol Middleware {
    associatedtype ReduxStore: Store
    static var middleware: ReduxStore.Middleware { get }
}

//struct CurrentWeatherMiddleware: Middleware {
//    typealias ReduxStore = CitySearchStore
//        
//    static var middleware: CitySearchStore.Middleware {
//        return { (dispatch: Dispatch, getState: @escaping () -> CitySearchState) in
//            return { (next: @escaping Dispatch) in
//                return { (action: Action) in
//                    print("Logging state")
//                    print(getState())
//                    next(action)
//                    print(getState())
//                    print("End logging state")
//                }
//            }
//        }
//    }
//}
