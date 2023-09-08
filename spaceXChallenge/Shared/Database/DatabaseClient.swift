//
//  DatabaseClient.swift
//  spaceXChallenge
//
//  Created by Roger Morales Jiménez on 07/09/23.
//

import Foundation
import Combine
import RealmSwift

class DatabaseClient: DatabaseProvider {
    
    private let database: Realm
    static let instance = DatabaseClient()
    
    private init() {
        do {
            database = try Realm()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
        
    // MARK: - DatabaseProvider
    
    func fetchData() -> AnyPublisher<[LaunchPersistedObject], Never> {
        var result = [LaunchPersistedObject]()
        
        result.append(contentsOf: database.objects(LaunchPersistedObject.self))
        return Just(result).eraseToAnyPublisher()
    }
    
    func saveData(_ inputData: [LaunchPersistedObject]) {
        for itemToSave in inputData {
            database.writeAsync { [unowned self] in
                database.add(itemToSave,update: .modified)
            }
        }
    
    }


}

