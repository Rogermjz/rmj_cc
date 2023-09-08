//
//  Models.swift
//  spaceXChallenge
//
//  Created by Roger Morales Jiménez on 06/09/23.
//

import Foundation
import RealmSwift


struct Launch: Codable {
    var flightNumber:  Int
    var missionName:   String
    var launchDateUtc: String
    var launchSuccess: Bool?
    var details:       String?
    var rocket:        RocketModel
    var launchSite:    LaunchSiteData
    var links:         LinksModel
    
    func getLaunchDate() -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        guard let date = formatter.date(from: launchDateUtc) else {
            return ""
        }
        
        formatter.dateFormat = "EEEE, MMM d, yyyy"
        return formatter.string(from: date)
    }
}

struct LinksModel: Codable {
    var missionPatchSmall: String?
    var articleLink:       String?
    var wikipedia:         String?
    var videoLink:         String?
    var flickrImages:      [String]
    
}

struct LaunchSiteData: Codable {
    var siteName:     String
    var siteNameLong: String
    
}

struct RocketModel: Codable {
    var rocketName: String
    var rocketType: String
    
}


// MARK: - Realm Object

class LaunchPersistedObject: Object {
    @objc dynamic var flightNumber: Int = 0
    @objc dynamic var missionName: String = ""
    @objc dynamic var launchDateUtc: String = ""
    @objc dynamic var details: String? = nil
    
    dynamic var launchSuccess = RealmOptional<Bool>()
    
    @objc dynamic var rocketName: String = ""
    @objc dynamic var rocketType: String = ""
    @objc dynamic var siteName: String = ""
    @objc dynamic var siteNameLong: String = ""
    
    @objc dynamic var missionPatchSmall: String? = nil
    @objc dynamic var articleLink: String? = nil
    @objc dynamic var wikipedia: String? = nil
    @objc dynamic var videoLink: String? = nil
    let flickrImages = List<String>()
    
    override class func primaryKey() -> String? { return "flightNumber" }
}




