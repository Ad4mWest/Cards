//  RemoteImage.swift
//  Cards
//  Created by Adam West on 12.01.2024.

import SwiftUI
import Combine

struct AsyncImageView: View {
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
    
    init(url: String) {
        downloader = ImageDownloader(url: url)
    }
    
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
