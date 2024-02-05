//  Collection+Extension.swift
//  Cards
//  Created by Adam West on 30.01.2024.

import Foundation

extension Collection {
    func isNotEmpty() -> some Equatable {
        self.isEmpty == false
    }
}
