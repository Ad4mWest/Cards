//  ButtonModifier.swift
//  Cards
//  Created by Adam West on 01.02.2024.

import SwiftUI

struct DetailButtonsModifier: ViewModifier {
    // MARK: Public Properties
    var rotation: Double
    var editingButtonsHidden: Bool
    
    // MARK: Lifecycle
    func body(content: Content) -> some View {
        content
            .frame(width: 100, height: 50)
            .foregroundColor(.mainAppC)
            .capsuleAnimation(rotation)
            .hiddenConditionally(
                editingButtonsHidden
            )
    }
}

extension View {
    func configurationDetailButton(
        _ rotation: Double,
        _ editingButtonsHidden: Bool) -> some View {
            return self.modifier(
                DetailButtonsModifier(
                    rotation: rotation,
                    editingButtonsHidden: editingButtonsHidden
                )
            )
        }
}
