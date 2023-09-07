//
//  LaunchDetailsView.swift
//  spaceXChallenge
//
//  Created by Roger Morales Jiménez on 06/09/23.
//

import SwiftUI

struct LaunchDetailsView: View {
    @StateObject var viewModel = LaunchDetailsViewModel()
    let inputLaunch: Launch
    let tapOnLinkAction: (URL) -> Void
    
    var body: some View {
        ScrollView(.vertical){
            VStack(spacing: 10) {
                ZStack{
                    Color.white
                        .cornerRadius(13, corners: [.bottomLeft, .bottomRight])
                        .shadow(color: .black, radius: 3, x: 0, y: 5)
                    
                    VStack{
                        Spacer(minLength: 5)
                        Text("Details")
                            .foregroundColor(Color.OrangeProject)
                            .font(.title)
                            .leadingAlignment()
                            .padding(5)
                        
                        if !viewModel.flickrImages.isEmpty {
                            ImagesCarousel(imageStrings: viewModel.flickrImages)
                            
                        }
                        
                        DateView(inputText: viewModel.date ?? "", inputColor: Color.PinkProject)
                            .padding(.leading, 10)
                            .leadingAlignment()
                        
                        Spacer(minLength: 10)
                        
                        HStack{
                            
                            RoundedText(inputText: "Rocket name: " + (viewModel.rocketName ?? ""))
                            
                            Spacer()
                            
                            RoundedText(inputText: "Rocket type: " + (viewModel.rocketType ?? ""))

                            
                        }
                        .padding(.bottom, 5)
                        .padding(.horizontal, 10)
                    }
                }
                VStack(spacing: 10){
                    Text(viewModel.site ?? "")
                    
                    Text(viewModel.details ?? "")
                    
                    HStack{
                        if let videoLink = viewModel.videoString, let url = URL(string: videoLink) {
                            Button(action: {
                                tapOnLinkAction(url)
                            }, label: {
                                Image(systemName: "video.circle.fill")
                                    .font(.system(size: 50))
                                    .foregroundColor(Color.red)
                            })

                        }
                        
                        Spacer()
                        
                        if let wikiLink = viewModel.wikiString, let url = URL(string: wikiLink) {
                            Button(action: {
                                tapOnLinkAction(url)
                            }, label: {
                                Image(systemName: "book.circle.fill")
                                    .font(.system(size: 50))
                                    .foregroundColor(Color.FirstGradientColor)
                            })

                        }

                    }
                    
                    
                }.padding(10)
            }
        }
        .background(Color.LightPinkProject)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarTitle(viewModel.missionName ?? "")
        .toolbarBackground(Color.LightPinkProject, for: .navigationBar)
        .onLoad {
            viewModel.setUpLaunchData(inputData: inputLaunch)
        }
    }
}

struct RoundedText: View {
    let inputText: String
    
    var body: some View {
        Text(inputText)
            .foregroundColor(Color.white)
            .font(.body)
            .padding(5)
            .background(Color.PurpleProjectColor)
            .cornerRadius(13)
    }
}

struct DateView: View {
    let inputText:  String
    let inputColor: Color
    
    var body: some View {
        HStack(spacing: 0) {
            Image(systemName: "calendar.circle.fill")
                .foregroundColor(inputColor)
            Text(inputText)
                .font(.italic(.caption)())
                .foregroundColor(inputColor)
                .padding(.leading, 10)
        }
    }
}
