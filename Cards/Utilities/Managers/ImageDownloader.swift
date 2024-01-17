//  ImageDownloader.swift
//  Cards
//  Created by Adam West on 15.01.2024.

import SwiftUI
import Combine

final class ImageDownloader: ObservableObject {
    // MARK: Private properties
    @Published private(set) var image: UIImage?
    
    private let url: String
    private var cancellable: AnyCancellable?
    
    // MARK: Initialization
    init(url: String) {
        self.url = url
    }
    
    // MARK: Public methods
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

