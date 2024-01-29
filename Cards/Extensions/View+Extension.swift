//  View+Extension.swift
//  Cards
//  Created by Adam West on 24.01.2024.

import SwiftUI

extension View where Self == ActivityIndicator {
    func configure(_ configuration: @escaping (Self.UIView)->Void) -> Self {
        return Self.init(
            isAnimating: self.isAnimating,
            configuration: configuration
        )
    }
}
