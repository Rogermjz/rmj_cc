//
//  AppRouter.swift
//  spaceXChallenge
//
//  Created by Roger Morales Jiménez on 06/09/23.
//

import Foundation

enum AppRouter: RequestInfoConvertible {
    
    case getMissionsList
    
    var endpoint: String {
        "https://api.spacexdata.com/v3"
    }
    
    var urlString: String {
        "\(endpoint)/\(path)"
    }
    
    var path: String {
        switch self {
        case .getMissionsList:
            return "launches/past"
        }
    }
    
    func asRequestInfo() -> RequestInfo {
        let requestInfo: RequestInfo = RequestInfo(url: urlString)
                
        
        return requestInfo
    }

}
