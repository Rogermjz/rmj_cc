//
//  LaunchListViewModel.swift
//  spaceXChallenge
//
//  Created by Roger Morales Jiménez on 06/09/23.
//

import Foundation
import RealmSwift
import Combine

class LaunchListViewModel: ObservableObject {
    
    @Published var launchs = [Launch]()
    
    var networkClient: DataFetcher
    var dbClient:      DbFetcher
    
    private var cancellable = Set<AnyCancellable>()
    
    private var hasAlreadyAccess: Bool {
        get {
            if let lastAccess = UserDefaults.standard.object(forKey: "LastAPIAccess") as? Date {
                return Calendar.current.isDate(Date(), inSameDayAs: lastAccess)
            }
            return false
        }
    }
    
    init(dataFetcher: DataFetcher, dbFetcher: DbFetcher ) {
        self.networkClient = dataFetcher
        self.dbClient      = dbFetcher
    }
    
    func getLaunchs() {
        
        if hasAlreadyAccess {
            dbClient
                .getMissionsList()
                .sink(receiveValue: {[weak self] values in
                    self?.launchs = self?.prepareDataFromDB(values) ?? []
                })
                .store(in: &cancellable)
        } else {
            networkClient
                .getMissionsList()
                .sink(receiveCompletion: { _ in}, receiveValue: {[weak self] values in
                    self?.launchs = values
                    self?.saveDataDB(values)
                })
                .store(in: &cancellable)
        }
        
    }
        
    private func saveDataDB(_ launchList: [Launch]) {
        dbClient.saveData(prepareDataToSave(launchList))
    }
    
    private func prepareDataToSave(_ launchList:[Launch]) -> [LaunchPersistedObject] {
        
        var objectsToSave = [LaunchPersistedObject]()
        
        for item in launchList {
            let launchObject           = LaunchPersistedObject()
            launchObject.flightNumber  = item.flightNumber
            launchObject.missionName   = item.missionName
            launchObject.launchDateUtc = item.launchDateUtc
            launchObject.details       = item.details
            launchObject.launchSuccess.value = item.launchSuccess
            

            launchObject.rocketName = item.rocket.rocketName
            launchObject.rocketType = item.rocket.rocketType
            

            launchObject.siteName     = item.launchSite.siteName
            launchObject.siteNameLong = item.launchSite.siteNameLong

            launchObject.articleLink       = item.links.articleLink
            launchObject.missionPatchSmall = item.links.missionPatchSmall
            launchObject.videoLink         = item.links.videoLink
            launchObject.wikipedia         = item.links.wikipedia
            
            launchObject.flickrImages.append(objectsIn: item.links.flickrImages)


            objectsToSave.append(launchObject)
        }
        
        return objectsToSave

    }
    
    private func prepareDataFromDB(_ launchList:[LaunchPersistedObject]) -> [Launch] {
        
        var result = [Launch]()
        
        for storedItem in launchList {
            
            let rocket = RocketModel(rocketName: storedItem.rocketName,
                                     rocketType: storedItem.rocketType)
            
            let launchSite = LaunchSiteData(siteName: storedItem.siteName,
                                            siteNameLong: storedItem.siteNameLong)
            
            var images = [String]()
            images.append(contentsOf: storedItem.flickrImages)
            
            let links = LinksModel(missionPatchSmall: storedItem.missionPatchSmall,
                                   articleLink: storedItem.articleLink,
                                   wikipedia: storedItem.wikipedia,
                                   videoLink: storedItem.videoLink,
                                   flickrImages: images)
            
            let valueToAppend = Launch(flightNumber: storedItem.flightNumber,
                                       missionName: storedItem.missionName,
                                       launchDateUtc: storedItem.launchDateUtc,
                                       launchSuccess: storedItem.launchSuccess.value,
                                       details: storedItem.details,
                                       rocket: rocket,
                                       launchSite: launchSite,
                                       links: links)

            
            result.append(valueToAppend)
        }
        
        return result

    }
    
}
