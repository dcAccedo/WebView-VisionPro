//
//  BottomComicsView.swift
//  MV-Project
//
//  Created by Daniel Coria on 22/08/23.
//

import SwiftUI

struct BottomComicsView: View {
    @EnvironmentObject private var store: StoreCharacter
    
    var body: some View {
        VStack {
            HStack {
                Text("Comics")
            }
  
            ScrollView(.horizontal) {
                HStack {
                    ForEach(store.comics) { item in
                        AsyncImage(
                            url: URL(string: item.thumbnail.path + "." + item.thumbnail.extension),
                            content: { image in
                                image
                                    .resizable()
                                    .frame(width: 130, height: 200)
                                    .scaledToFit()
                                    .padding(.horizontal, 6)
                                    .padding(.vertical, 6)
                                    
                            }, placeholder:  {
                                ProgressView()
                                    .frame(width: 100)
                            })
                        .padding(.horizontal, 10)
                        
                        Spacer()
                    }
                }
                .padding(.leading)
            }
            .task {
                await populateComics(character: characterSelected)
            }
        }
    }
}

extension BottomComicsView {
    private func populateComics(character: Character) async {
        do {
            try await store.fetchComic(character: character)
        } catch {
            print(error.localizedDescription)
        }
    }
}
