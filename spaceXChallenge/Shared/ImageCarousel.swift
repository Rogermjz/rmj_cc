//
//  ImageCarousel.swift
//  spaceXChallenge
//
//  Created by Roger Morales Jiménez on 06/09/23.
//

import SwiftUI

struct ImagesCarousel: View {
    
    @State private var currentIndex: Int = 0
    @GestureState private var dragOffset: CGFloat = 0
    let imageStrings: [String]
    
    var body: some View {
        VStack{
            ZStack{
                ForEach(0..<imageStrings.count, id: \.self) { index in
                    AsyncImage(url: URL(string: imageStrings[index]), content: { image in
                        image.resizable()
                            .frame(width: 350, height: 300)
                    }, placeholder: {
                        ProgressView()
                            .tint(Color.PurpleProjectColor)
                    })
                    .cornerRadius(25)
                    .opacity(currentIndex == index ? 1.0 : 0.3)
                    .scaleEffect(currentIndex == index ? 1.0 : 0.8)
                    .offset(x: CGFloat(index - currentIndex) * 300 + dragOffset, y: 0)
                }
            }.gesture(
                DragGesture()
                    .onEnded({ value in
                        let threshhold: CGFloat = 50
                        if value.translation.width > threshhold {
                            withAnimation {
                                currentIndex = max(0, currentIndex - 1)
                            }
                        } else if value.translation.width < -threshhold {
                            withAnimation {
                                currentIndex = min(imageStrings.count - 1, currentIndex + 1)
                            }
                        }
                    })
            )
            
            HStack{
                Button {
                    withAnimation {
                        currentIndex = max(0, currentIndex - 1)
                    }

                } label: {
                    Image(systemName: "arrow.left")
                        .font(.title)
                        .tint(Color.PurpleProjectColor)
                }
                
                Spacer()
                
                Button {
                    withAnimation {
                        currentIndex = min(imageStrings.count - 1 , currentIndex + 1)
                    }
                } label: {
                    Image(systemName: "arrow.right")
                        .font(.title)
                        .tint(Color.PurpleProjectColor)
                }
            }.padding()
        }
    }
}
