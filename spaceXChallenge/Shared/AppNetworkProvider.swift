//
//  AppNetworkProvider.swift
//  spaceXChallenge
//
//  Created by Roger Morales Jiménez on 06/09/23.
//

import Foundation
import Combine

protocol DataFetcher {
    func getMissionsList() -> AnyPublisher<[Launch],Error>
}

class AppNetworkClient: DataFetcher {
    
    var networkClient: NetworkProvider = NetworkClient.instance
    
    func getMissionsList() -> AnyPublisher<[Launch], Error> {
        networkClient.request(AppRouter.getMissionsList).decode()
    }

    
    
}
