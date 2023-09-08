//
//  AppDatabaseProvider.swift
//  spaceXChallenge
//
//  Created by Roger Morales Jiménez on 07/09/23.
//

import Foundation
import Combine

protocol DatabaseProvider {
    func fetchData() -> AnyPublisher<[LaunchPersistedObject], Never>
    func saveData(_ inputData: [LaunchPersistedObject])
}

protocol DbFetcher {
    func getMissionsList() -> AnyPublisher<[LaunchPersistedObject], Never>
    func saveData(_ inputData: [LaunchPersistedObject])
}


class AppDBClient: DbFetcher {
    
    var databaseClient: DatabaseProvider = DatabaseClient.instance
    
    func getMissionsList() -> AnyPublisher<[LaunchPersistedObject], Never> {
        databaseClient.fetchData()
    }
    
    func saveData(_ inputData: [LaunchPersistedObject]) {
        guard !inputData.isEmpty else {return }
        databaseClient.saveData(inputData)
        UserDefaults.standard.set(Date(), forKey: "LastAPIAccess")
    }

    
    
}
