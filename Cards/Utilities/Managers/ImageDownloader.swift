//  ImageDownloader.swift
//  Cards
//  Created by Adam West on 15.01.2024.

import SwiftUI
import Combine

final class ImageDownloader: ObservableObject {
    @Published private(set) var image: UIImage?
    private let url: String
    private var cancellable: AnyCancellable?
    
    init(url: String) {
        self.url = url
    }
    
    func start() {
        guard let urlString = URL(string: url) else {
            return
        }
        cancellable = URLSession(configuration: .default)
            .dataTaskPublisher(for: urlString)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .assign(to: \.image, on: self)
    }
    
    func stop() {
        cancellable?.cancel()
    }
    deinit {
        cancellable?.cancel()
    }
}

