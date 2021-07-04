//
//  Publisher+mapToResult.swift
//  Weather - Redux
//
//  Created by Martin on 26.06.2021.
//

import Combine

extension Publisher {
    func mapToResult() -> AnyPublisher<Result<Output, Failure>, Never> {
        self
            .map(Result.success)
            .catch { Just(Result.failure($0)) }
            .eraseToAnyPublisher()
    }
}
