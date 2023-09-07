//
//  LaunchListCoordinator.swift
//  spaceXChallenge
//
//  Created by Roger Morales Jiménez on 06/09/23.
//

import SwiftUI

struct LaunchListCoordinator: View {
    @State private var selectedLaunch: Launch?
    @Environment(\.openURL) var openURL
    
    
    var body: some View {
        VStack{
            LaunchListView { tappedItem in
                selectedLaunch = tappedItem
            }
            .listStyle(.plain)
            .navigationBarTitle("Space X 🚀")
            .toolbarBackground(Color.LightPinkProject, for: .navigationBar)
            
            if let _ = selectedLaunch {
                EmptyNavigationLink(destination: LaunchDetailsView(inputLaunch: selectedLaunch!, tapOnLinkAction: tapOnLinkAction), selectedItem: $selectedLaunch)
            }
        }
    }
    
    
    
    private func tapOnLinkAction(url: URL) {
        openURL(url)
    }
}

// MARK: - ViewDidLoadModifier
struct ViewDidLoadModifier: ViewModifier {
    @State private var isViewDidLoad = false
    private let action: (() -> Void)

    init(perform action: @escaping (() -> Void)) {
        self.action = action
    }

    func body(content: Content) -> some View {
        content.onAppear {
            if isViewDidLoad == false {
                isViewDidLoad = true
                action()
            }
        }
    }
}

