//  ActivityIndicator.swift
//  Cards
//  Created by Adam West on 24.01.2024.

import SwiftUI

struct ActivityIndicator: UIViewRepresentable {
    typealias UIView = UIActivityIndicatorView
    
    // MARK: Public Properties
    var isAnimating: Bool
    var configuration = {
        (indicator: UIView) in
    }
    
    // MARK: Public methods
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIView {
        return UIView()
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<Self>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
        configuration(uiView)
    }
}
