//  RemoteImage.swift
//  Cards
//  Created by Adam West on 12.01.2024.

import SwiftUI
import Combine

struct CardRemoteImage: View {
    // MARK: Private properties
    @ObservedObject private var downloader: ImageDownloader
    
    private var image: some View {
        Group {
            if downloader.image != nil {
                Image(uiImage: downloader.image!).resizable()
            } else {
                ProgressView()
            }
        }
    }
    
    // MARK: Initialization
    init(url: String) {
        downloader = ImageDownloader(url: url)
    }
    
    // MARK: Lifecycle
    var body: some View {
        image
            .onAppear {
                downloader.start()
            }
            .onDisappear {
                downloader.stop()
            }
    }
}
