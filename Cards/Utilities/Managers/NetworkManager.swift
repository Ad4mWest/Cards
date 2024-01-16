//  NetworkManager.swift
//  Appotizers
//  Created by Adam West on 11.01.2024.

import UIKit
import Combine

final class NetworkManager {
    static let shared = NetworkManager()
    private let cache = NSCache<NSString, UIImage>()
    
    static let baseURL = "https://randomuser.me/"
    private let cardURL = baseURL + "api/?inc=name,picture"
    
    private init() {}
    
    func getName(completed: @escaping (Result<Person, APError>) -> Void) {
        guard let url = URL(string: cardURL) else {
            completed(.failure(APError.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            if let _ = error {
                completed(.failure(APError.unableToComplete))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(APError.invalidResponse))
                return
            }
            guard let data = data else {
                completed(.failure(APError.invalidData))
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(PersonResponse.self, from: data)
                completed(.success(decodedResponse.results[0].name))
            } catch {
                completed(.failure(APError.invalidData))
            }
        }
        
        task.resume()
    }
    
    func downloadImage(fromURLString urlString: String, completed: @escaping(UIImage?) -> Void) {
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let data = data, let image = UIImage(data: data) else {
                completed(nil)
                return
            }
            
            self.cache.setObject(image, forKey: cacheKey)
            completed(image)
        }
        task.resume()
    }
}
