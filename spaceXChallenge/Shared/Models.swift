//
//  Models.swift
//  spaceXChallenge
//
//  Created by Roger Morales Jiménez on 06/09/23.
//

import Foundation

//mission_name, site_name, launch


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
    var missionPatch:      String?
    var missionPatchSmall: String?
    var articleLink:       String?
    var wikipedia:         String?
    var videoLink:         String?
    var flickrImages:      [String]
    
}

struct LaunchSiteData: Codable {
    var siteId:       String
    var siteName:     String
    var siteNameLong: String
    
}

struct RocketModel: Codable {
    var rocketName: String
    var rocketType: String
    
}


