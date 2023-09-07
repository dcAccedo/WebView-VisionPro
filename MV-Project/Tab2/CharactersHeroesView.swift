//
//  CharactersHeroesView.swift
//  MV-Project
//
//  Created by Daniel Coria on 22/08/23.
//

import SwiftUI

struct CharactersHeroesView: View {
    @EnvironmentObject private var store: StoreCharacter
    @Environment(\.openWindow) private var openWindow
    
    @State private var isPortrait = false
    @State var columns: Int = 0
    
    
    var dynamicLayout: [GridItem]  {
        return Array(repeating: GridItem(.flexible(minimum: 250)), count: columns)
    }
    
    var vGridLayout = [
        GridItem(.adaptive(minimum: 250, maximum: 400))
    ]
    
    var body: some View {
        NavigationView {
            VStack {
//                LinearGradient(gradient: Gradient(colors: [.gray, .gray, .white]),
//                               startPoint: .top,
//                               endPoint: .bottomTrailing)
//                .edgesIgnoringSafeArea(.all)
                
                Button {
                    openWindow(id: "WebView1")
                } label: {
                    Text("First")
                }
                
                
                ScrollView {
                    // using stacks
                    //                GridStack(rows: viewModel.marvelCharacters.count, columns: 1, characters: viewModel.marvelCharacters)
                    
                    // using lazy grid
                    LazyVGrid(columns: vGridLayout, spacing: 20) {
                        ForEach(store.characters) { item in
                            
                            NavigationLink(destination: DetailHeroView(selected: item)) {
                                GridCharacter(item: item)
                                    .hoverEffect()
                            }
                            .buttonStyle(.plain)
                            
                        }
                    }
                    .padding(.horizontal)
//                    .hoverEffect()
                }
            }
            .navigationTitle("Marvel Heroes")
        }
        .task {
            await populateProducts()
        }
        .navigationViewStyle(StackNavigationViewStyle())
        
    }
}

extension CharactersHeroesView {
    private func populateProducts() async {
        do {
            try await store.loadCharacters()
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct GridCharacter: View {
    var item: Character
    
    var body: some View {
        VStack{
            AsyncImage(
                url: URL(string: item.thumbnail.path + "." + item.thumbnail.extension),
                content: { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 6)
                }, placeholder:  {
                    ProgressView()
                        .frame(width: 100)
                })
            .padding(.horizontal, 10)
            
            Spacer()
            Text("\(item.name)")
                .foregroundColor(Color(.white))
                .font(.title2)
                .padding()
            Spacer()
        }
        .contentShape(.hoverEffect, .rect(cornerRadius: 16))
        
    }
}

struct GridStack: View {
    let rows: Int
    let columns: Int
    let characters: [Character]
    
    var body: some View {
        VStack {
            ForEach(0 ..< rows, id: \.self) { row in
                HStack {
                    ForEach(0 ..< columns, id: \.self) { column in
//                        NavigationLink(destination: RedView()) {
                            GridCharacter(item: characters[row])
//                        }
                        
                    }
                }
                .frame(height: 250)
            }
        }
        .foregroundColor(.green)
        
    }
}
