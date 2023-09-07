//
//  DetailHeroView.swift
//  Marvel-swiftUI
//
//  Created by Daniel Coria on 08/04/21.
//

import SwiftUI

struct DetailHeroView: View {
    var title: String = ""
    @State var selected: Character?
    @EnvironmentObject private var store: StoreCharacter
    @Environment(\.openWindow) private var openWindow
//    @Environment(\.dismissWindow) private var dismissWindow
    
    @State var comicSize: CGSize = CGSize(width: 0, height: 0)
    
    /// The app's player model.
//    @Environment(PlayerModel.self) private var player
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    AsyncImage(
                        url: URL(string: selected!.thumbnail.path + "." + selected!.thumbnail.extension),
                        content: { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 350, height: 350)
                        }, placeholder:  {
                            ProgressView()
                                .frame(width: 100)
                        })
                    
                    let desc = selected?.description ?? ""
                    Text(desc.isEmpty ? "No description" : desc)
                        .padding()
                    
                    Spacer()
                    
                    Button {
                        openWindow(id: "VideoPlayerWindow")
//                        player.makePlayerViewController()
//                        player.loadVideo()
//                        player.play()
//                        VideoView()
                    } label: {
                        Text("play moview")
                    }
                    .hoverEffect()

                    
//                    ScrollView(.horizontal) {
//                        HStack {
//                            ForEach(store.comics) { item in
//                                VStack {
//                                    AsyncImage(
//                                        url: URL(string: item.thumbnail.path + "." + item.thumbnail.extension),
//                                        content: { image in
//                                            image
//                                                .resizable()
//                                                .frame(width: 200, height: 300)
//                                                .scaledToFit()
//                                        }, placeholder:  {
//                                            ProgressView()
//                                                .frame(width: 100)
//                                        })
//                                    
//                                    Text(item.title)
//                                        .padding()
//                                        .foregroundColor(Color(.label))
//                                }
//                                
//                                
//                            }
//                        }
//                        .padding(.leading)
//                    }
                }
            }
        }
        .task {
            characterSelected = selected ?? .empty
            await populateComics(character: selected!)
        }
        .onAppear {
            openWindow(id: "ComicsWindow")
            openWindow(id: "Object")
        }
        .onDisappear {
//            dismissWindow(id: "ComicsWindow")
        }
        .navigationTitle(selected?.name ?? "")
        
    }
}

extension DetailHeroView {
    private func populateComics(character: Character) async {
        do {
            try await store.fetchComic(character: character)
        } catch {
            print(error.localizedDescription)
        }
    }
}
