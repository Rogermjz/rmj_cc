//
//  LaunchListView.swift
//  spaceXChallenge
//
//  Created by Roger Morales Jiménez on 06/09/23.
//

import SwiftUI

struct LaunchListView: View {
    @StateObject var viewModel =  LaunchListViewModel(dataFetcher: AppNetworkClient(), dbFetcher: AppDBClient())
    let tapOnCellAction: (Launch) -> Void
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 0) {
                ForEach(viewModel.launchs, id: \.flightNumber) { launchItem in
                    
                    Button {
                        tapOnCellAction(launchItem)
                    } label: {
                        LaunchItemCell(launchItem: launchItem)
                    }
                    .background(Color.PurpleProjectColor)
                    .cornerRadius(13)
                    .padding(5)
                    

                }
            }.padding(.horizontal, 5)
            
        }
        .background(LinearGradient(gradient: Gradient(colors: [Color.FirstGradientColor, Color.LastGradientColor]), startPoint: .topLeading, endPoint: .bottomTrailing))
        .onAppear{
            viewModel.getLaunchs()
        }
    }
}
