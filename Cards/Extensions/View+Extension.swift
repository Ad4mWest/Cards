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

extension View {
    func hiddenConditionally(_ isHidden: Bool) -> some View {
        return isHidden ? AnyView(self.hidden()) : AnyView(self)
    }
    func capsuleAnimation(_ angularGradient: AngularGradient, _ angle: Double) -> some View {
        return AnyView(
            self.background(
                Capsule()
                    .strokeBorder(
                        angularGradient,
                        lineWidth: 3
                    )
                    .rotationEffect(.degrees(angle))
                    .animation(
                        .interpolatingSpring(
                            mass: 1,
                            stiffness: 1,
                            damping: 0.5,
                            initialVelocity: 5
                        )
                    )
            )
        )
    }
}
