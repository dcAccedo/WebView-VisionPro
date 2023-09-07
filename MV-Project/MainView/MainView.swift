//
//  MainView.swift
//  MV-Project
//
//  Created by Daniel Coria on 15/08/23.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            CharactersHeroesView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Marvel Heroes")
                }
            
            CatalogListScreen()
                .tabItem {
                    Image(systemName: "command")
                    Text("Items")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
