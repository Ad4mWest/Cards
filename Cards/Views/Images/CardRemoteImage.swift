//  CardRemoteImage.swift
//  Cards
//  Created by Adam West on 12.01.2024.

import SwiftUI
import Combine

final class ImageProvider: ObservableObject {
    // MARK: Public Properties
    @Published var image = UIImage(named: "labelPlaceholder")!
    
    // MARK: Private properties
    private var cancellable: AnyCancellable?
    private let imageLoader = NetworkImageLoader()
    
    // MARK: Public methods
    func loadImage(url: URL) {
        self.cancellable = imageLoader.publisher(for: url)
            .sink(receiveCompletion: { completion in
                if case .failure = completion {
                    self.image = UIImage(named: "labelPlaceholder")!
                }
            }, receiveValue: { image in
                self.image = image
            }
            )
    }
}

struct CardRemoteImage: View {
    // MARK: Public Properties
    var url: URL?
    
    // MARK: Private properties
    @StateObject private var viewModel = ImageProvider()
    
    // MARK: Initialization
    init(url: String) {
        self.url = URL(string: url)
    }
    
    // MARK: Lifecycle
    var body: some View {
        Image(uiImage: viewModel.image)
            .resizable()
            .aspectRatio(contentMode: .fit)
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
