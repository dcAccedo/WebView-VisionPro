//
//  VideoPlayerView.swift
//  MV-Project
//
//  Created by Daniel Coria on 22/08/23.
//

import Foundation
import WebKit
import SwiftUI
import AVKit
import Observation

struct VideoPlayerView: UIViewRepresentable {
    
    func makeUIView(context: Context) ->  WKWebView {
        WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let youtubeURL = URL(string: "https://www.accedo.tv") else { return }
        uiView.scrollView.isScrollEnabled = false
        uiView.load(URLRequest(url: youtubeURL))
    }
}

//struct VideoView: View {
//    private let player = AVPlayer(url: URL(string: "https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8")!)
//    
//    var body: some View {
//        VideoPlayer(player: player)
//            .onAppear() {
//                // Start the player going, otherwise controls don't appear
//                player.play()
//            }
//            .onDisappear() {
//                // Stop the player when the view disappears
//                player.pause()
//            }
//    }
//}
//
//
//
//@Observable class PlayerModel {
//    /// An object that manages the playback of a video's media.
//    private var player = AVPlayer()
//    
//    /// This value is set by a call to the `makePlayerViewController()` method.
//    private var playerViewController: AVPlayerViewController? = nil
//    private var playerViewControllerDelegate: AVPlayerViewControllerDelegate? = nil
//    
//    
//    /// Creates a new player view controller object.
//    /// - Returns: a configured player view controller.
//    func makePlayerViewController() -> AVPlayerViewController {
////        let delegate = PlayerViewControllerDelegate(player: self)
//        let controller = AVPlayerViewController()
//        controller.player = player
////        controller.delegate = delegate
//        
//        // Set the model state
//        playerViewController = controller
////        playerViewControllerDelegate = delegate
//        
//        return controller
//    }
//    
//    func loadVideo() {
//        Task { @MainActor in
//            replaceCurrentItem()
//        }
//    }
//    
//    func play() {
//        player.play()
//    }
//    
//    private func replaceCurrentItem() {
//        // Create a new player item and set it as the player's current item.
//        let playerItem = AVPlayerItem(url: URL(string: "https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8")!)
//        // Set external metadata on the player item for the current video.
//        //        playerItem.externalMetadata = createMetadataItems(for: video)
//        // Set the new player item as current, and begin loading its data.
//        player.replaceCurrentItem(with: playerItem)
//        //        logger.debug("🍿 \(video.title) enqueued for playback.")
//    }
//    
//    /// Clears any loaded media and resets the player model to its default state.
//    func reset() {
//        player.replaceCurrentItem(with: nil)
//    }
//    
//}
//
//struct VideoPlayerView: View {
//    var body: some View {
//        VideoPlayer(player: AVPlayer(url:  URL(string: "https://www.youtube.com/watch?v=itm8efx8k8U")!))
//            .frame(height: 400)
//    }
//    
//    
//}
