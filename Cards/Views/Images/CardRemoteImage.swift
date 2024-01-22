//  RemoteImage.swift
//  Cards
//  Created by Adam West on 12.01.2024.

import SwiftUI
import Combine

final class ImageProvider: ObservableObject {
    @Published var image = UIImage(named: "labelPlaceholder")!
    
    private var cancellable: AnyCancellable?
    private let imageLoader = NetworkImageLoader()

    func loadImage(url: URL) {
        self.cancellable = imageLoader.publisher(for: url)
            .sink(receiveCompletion: { failure in
            print(failure)
        }, receiveValue: { image in
            self.image = image
        })
    }
}

struct CardRemoteImage: View {
    @StateObject private var viewModel = ImageProvider()
    
    var url: URL?
    
    init(url: String) {
        self.url = URL(string: url)
    }
    var body: some View {
        Image(uiImage: viewModel.image)
            .resizable()
            .frame(width: 225, height: 225)
            .clipShape(Circle())
            .onAppear {
                guard let url else {
                    return
                }
                viewModel.loadImage(url: url)
            }
            
    }
}
