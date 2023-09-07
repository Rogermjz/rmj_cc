//
//  LaunchListViewModel.swift
//  spaceXChallenge
//
//  Created by Roger Morales Jiménez on 06/09/23.
//

import Foundation

class LaunchListViewModel: ObservableObject {
    @Published var launchs = [Launch]()
    var networkClient: DataFetcher = AppNetworkClient()
    
    func getLaunchs() {
        //agregar validacion para solo hacer la consulta una vez
        networkClient
            .getMissionsList()
            .replaceError(with: [Launch]())
            .assign(to: &$launchs)
    }
    
}
