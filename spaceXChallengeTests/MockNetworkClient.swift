//
//  MockNetworkClient.swift
//  spaceXChallengeTests
//
//  Created by Roger Morales Jiménez on 08/09/23.
//

import Foundation
import Combine
@testable import spaceXChallenge

class MockNetworkClient: NetworkProvider {
    var response: (Data?, Error?) = (nil, NetworkError.invalidResponse)
    
    init(response: (Data?, Error?)) {
        self.response = response
    }
    
    func request(_ info: RequestInfoConvertible) -> AnyPublisher<Data, Error> {
        if let error = response.1 {
            return Fail(error: error)
                .eraseToAnyPublisher()
        } else if let data = response.0 {
            return Just(data)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } else {
            return Fail(error: NetworkError.invalidResponse)
                .eraseToAnyPublisher()
        }

    }

}
