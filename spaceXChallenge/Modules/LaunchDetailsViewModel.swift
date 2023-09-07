//
//  LaunchDetailsViewModel.swift
//  spaceXChallenge
//
//  Created by Roger Morales Jiménez on 06/09/23.
//

import Foundation
import Combine

class LaunchDetailsViewModel: ObservableObject {
    
    @Published private var launchData: Launch?
    
    @Published var missionName:   String?
    @Published var details:       String?
    @Published var site:          String?
    @Published var date:          String?
    @Published var rocketName:    String?
    @Published var rocketType:    String?
    @Published var videoString:   String?
    @Published var wikiString:    String?
    @Published var flickrImages = [String]()
    
    init() {
        bind()
    }
    
    private func bind() {
        //mapear la info al view model
        $launchData.map({ $0?.missionName }).assign(to: &$missionName)
        $launchData.map({ $0?.details }).assign(to: &$details)
        $launchData.map({ $0?.launchSite.siteNameLong }).assign(to: &$site)
        $launchData.map({ $0?.getLaunchDate() }).assign(to: &$date)
        $launchData.map({ $0?.rocket.rocketName }).assign(to: &$rocketName)
        $launchData.map({ $0?.rocket.rocketType }).assign(to: &$rocketType)
        $launchData.map({ $0?.links.wikipedia }).assign(to: &$wikiString)
        $launchData.map({ $0?.links.videoLink }).assign(to: &$videoString)
        $launchData.map({ [unowned self] in addImagesString(launch: $0) }).assign(to: &$flickrImages)
    }
    
    private func addImagesString(launch: Launch?) -> [String] {
        var result = [String]()
        
        for element in launch?.links.flickrImages ?? [] {
            result.append(element)
        }
        return result
    }
    
    func setUpLaunchData(inputData: Launch) {
        self.launchData = inputData
    }

}
