//  APIError.swift
//  Cards
//  Created by Adam West on 14.01.2024.

import Foundation

enum APIError: Error {
    case invalidURL(String)
    case invalidDecoding(String)
    case invalidData(String)
    case decodingError(Error)
    case unableToComplete(Error)
}
