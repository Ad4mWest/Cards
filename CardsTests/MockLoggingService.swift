//  MockLoggingService.swift
//  CardsTests
//  Created by Adam West on 02.02.2024.

import Foundation
import Cards

public class MockLoggingServiceImpl: LoggingService {
    // MARK: Public Properties
    var logReadCalled = false
    var logWriteCalled = false
    
    // MARK: Public methods
    public func logRead() {
        print("logRead")
        logReadCalled = true
    }
    
    public func logWrite() {
        print("logWrite")
        logWriteCalled = true
    }
}
