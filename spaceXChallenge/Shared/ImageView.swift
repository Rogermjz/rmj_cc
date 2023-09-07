//
//  ImageView.swift
//  spaceXChallenge
//
//  Created by Roger Morales Jiménez on 06/09/23.
//

import SwiftUI
import Foundation
import Combine

struct ImageView: View, Equatable {
    
    // to avoid redrawing after the uiImage has been set to something other than the initialized nil value or if it goes back to nil.
    static func == (lhs: ImageView, rhs: ImageView) -> Bool {
            let lhsImage = lhs.image
            let rhsImage = rhs.image
            if (lhsImage == nil && rhsImage != nil) || (lhsImage != nil && rhsImage == nil) {
                return false
            } else {
                return true
            }
        }
    
    @ObservedObject var imageLoader: UrlImageModel
    @State var image: UIImage = UIImage()

    init(withURL url: String) {
        imageLoader = UrlImageModel(url: URL(string: url))
    }

    func imageFromData(_ data: Data) -> UIImage {
        UIImage(data: data) ?? UIImage()
    }

    var body: some View {
        VStack {
            Image(uiImage: imageLoader.image ?? UIImage())
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width:90, height:90)
                //.background(Color.gray)
                .clipShape(Rectangle())
                //.overlay(Rectangle().stroke(Color.BlueProject, lineWidth: 4))
        }
    }
}

class UrlImageModel: ObservableObject {
    @Published var image: UIImage?
    private var url: URL?
    private var cancellable: AnyCancellable?
    private var imageCache = ImageCache.getImageCache()

    init(url: URL?) {
        self.url = url
        loadImage()
    }

    func loadImage() {
        if loadImageFromCache() {
            print("Cache hit")
            return
        }

        print("Cache missing, loading from url")
        loadImageFromUrl()
    }

    func loadImageFromCache() -> Bool {
        guard let url = url else {
            return false
        }

        guard let cacheImage = imageCache[url] else {
            return false
        }

        image = cacheImage
        return true
    }

    func loadImageFromUrl() {
        guard let url = url else {
            let config = UIImage.SymbolConfiguration(pointSize: 140, weight: .bold, scale: .large)
            image = UIImage(systemName: "photo.fill",withConfiguration: config) ?? UIImage()
            return
        }

        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            // set image into cache!
            .handleEvents(receiveOutput: { [unowned self] image in
                guard let image = image else {return}
                self.imageCache[url] = image
            })
            .receive(on: DispatchQueue.main)
            .assign(to: \.image, on: self)
    }
}

class ImageCache {
    var cache = NSCache<NSURL, UIImage>()

    subscript(_ key: URL) -> UIImage? {
        get { cache.object(forKey: key as NSURL) }
        set { newValue == nil ? cache.removeObject(forKey: key as NSURL) : cache.setObject(newValue!, forKey: key as NSURL) }
    }
}

extension ImageCache {
    private static var imageCache = ImageCache()

    static func getImageCache() -> ImageCache {
        return imageCache
    }
}
