//  NetworkImageLoader.swift
//  Cards
//  Created by Adam West on 19.01.2024.

import UIKit
import Combine

class NetworkImageLoader {
    // MARK: Private properties
    private let urlSession: URLSession
    private let cache: NSCache<NSURL, UIImage>
    
    // MARK: Initialization
    init(
        urlSession: URLSession = .shared,
        cache: NSCache<NSURL, UIImage> = .init()
    ) {
        self.urlSession = urlSession
        self.cache = cache
    }
    
    // MARK: Public methods
    func publisher(for url: URL) -> AnyPublisher<UIImage, Error> {
        if let image = cache.object(forKey: url as NSURL) {
            return Just(image)
                .setFailureType(to: Error.self)
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
        } else {
            return urlSession
                .dataTaskPublisher(for: url)
                .map(\.data)
                .tryMap { data in
                    guard let image = UIImage(data: data) else {
                        throw URLError(
                            .badServerResponse, userInfo: [
                                NSURLErrorFailingURLErrorKey: url
                            ]
                        )
                    }
                    return image
                }
                .receive(on: DispatchQueue.main)
                .handleEvents(
                    receiveOutput: { [cache] image in
                        cache.setObject(image, forKey: url as NSURL)
                    }
                )
                .eraseToAnyPublisher()
        }
    }
}
