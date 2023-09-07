//
//  MV_ProjectApp.swift
//  MV-Project
//
//  Created by Daniel Coria on 01/08/23.
//

import SwiftUI

@main
struct MV_ProjectApp: App {
    
    @StateObject private var store = Store(storeHTTPClient: DefaultStoreHTTPClient())
    @StateObject private var characters = StoreCharacter(storeCharacterHTTPClient: DefaultCharactersHTTPClient())
//    @State private var player = PlayerModel()
    
    var body: some Scene {
        
//        WindowGroup {
//            WebViewWindow()
//        }
//        .windowResizability(.contentSize)
////        .defaultSize(CGSize(width: 1500, height: 1500))
        
        WindowGroup {
            MainView()
                .environmentObject(store)
                .environmentObject(characters)
//                .environment(player)
        }
        
#if os(visionOS)
        // Defines an immersive space to present a destination in which to watch the video.
        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }
        // Set the immersion style to progressive, so the user can use the crown to dial in their experience.
        .immersionStyle(selection: .constant(.progressive), in: .progressive)
#endif
        
        WindowGroup (id: "SecondWindow"){
            BottomGalleryView()
        }
        
        WindowGroup(id: "SuggestionsWindow") {
            SuggestionView()
                .environmentObject(store)
        }
        
        WindowGroup(id: "VideoPlayerWindow") {
            VideoPlayerView()
//                .environmentObject(store)
        }
        
        WindowGroup(id: "ComicsWindow") {
            BottomComicsView()
                .environmentObject(characters)
        }
        .windowResizability(.contentSize)
        .defaultSize(CGSize(width: 1000, height: 300))
        
        WindowGroup(id: "WebView1") {
            WebViewWindow()
        }
        .windowResizability(.contentSize)
        .defaultSize(CGSize(width: 1000, height: 1000))
        
        
        WindowGroup(id: "StatsView") {
            StatsView()
        }
        .windowResizability(.contentSize)
        .defaultSize(CGSize(width: 500, height: 1000))
        
        
        WindowGroup(id: "Object") {
            DObject()
        }
        .windowStyle(.volumetric)
        .defaultSize(width: 0.9, height: 0.9, depth: 1, in: .meters)
    }
}
