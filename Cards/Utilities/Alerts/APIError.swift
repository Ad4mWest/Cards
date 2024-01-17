//  APIError.swift
//  Cards
//  Created by Adam West on 14.01.2024.

import Foundation

enum APIError: Error {
    case invalidURL(String)
    case invalidResponse
    case invalidData
    case decodingError
    case unableToComplete
}
