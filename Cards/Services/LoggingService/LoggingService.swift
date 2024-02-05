//  LoggingService.swift
//  Cards
//  Created by Adam West on 02.02.2024.

import Foundation

public protocol LoggingService {
    func logRead()
    func logWrite()
}

final class LoggingServiceImpl: LoggingService {
    // MARK: Public methods
    func logRead() {
        print("logRead")
    }
    
    func logWrite() {
        print("logWrite")
    }
}
