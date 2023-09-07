//
//  LaunchItemCell.swift
//  spaceXChallenge
//
//  Created by Roger Morales Jiménez on 06/09/23.
//

import SwiftUI

struct LaunchItemCell: View {
    let launchItem: Launch
    var body: some View {
        VStack{
            ZStack{
                Color.white
                    .cornerRadius(13)
                    .shadow(color: .black, radius: 3)
                HStack{
                    
                    ImageView(withURL: launchItem.links.missionPatchSmall ?? "")
                        .shadow(color: .black, radius: 5)
                    
                    
                    VStack {
                        Text(launchItem.missionName)
                            .font(.title3)
                            .foregroundColor(.OrangeProject)
                            .padding(.leading, 0)
                            .frame(maxWidth: .infinity)
                        
                        Spacer()
                        
                        Text(launchItem.launchSite.siteName)
                            .font(.body)
                            .foregroundColor(.PinkProject)
                            .padding(.leading, 0)
                            .frame(maxWidth: .infinity)
                        
                        Text(launchItem.launchSite.siteNameLong)
                            .font(.caption)
                            .foregroundColor(.PinkProject)
                            .padding(.leading, 0)
                            .frame(maxWidth: .infinity)
                                            
                    }
                }
                .padding(10)
            }
            HStack{
                DateView(inputText: launchItem.getLaunchDate(), inputColor: Color.YellowProject)
                    .leadingAlignment()
                
                if let _ = launchItem.launchSuccess {
                    HStack(spacing: 0) {
                        Text("Success: ")
                            .font(.caption2)
                            .foregroundColor(.white)
                            .trailingAlignment()
                        
                        Image(systemName: launchItem.launchSuccess! ? "checkmark.circle.fill" : "xmark.circle.fill")
                            .foregroundColor(launchItem.launchSuccess! ? Color.green : Color.red)

                    }
                }
            }.padding(5)
        
        }

    }
}

