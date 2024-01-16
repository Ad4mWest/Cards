//  APError.swift
//  Cards
//  Created by Adam West on 14.01.2024.

import Foundation

enum APError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case unableToComplete
}
